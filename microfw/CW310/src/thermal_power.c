/*
 * temp_sensor.c
 *
 * Created: 3/15/2021 3:20:53 PM
 *  Author: adewa

 Thermal and power management
 */
#include <asf.h>
#include "thermal_power.h"
#include "i2c_util.h"

#define MAX1617_I2C_ADDR 0x18
// #define MAX1617_I2C TWI0

//TODO: SW_STATE (PB26) if low should high-z fpga pins (maybe interrupt?)

#if 0
#define TWI_SUCCESS              0
#define TWI_INVALID_ARGUMENT     1
#define TWI_ARBITRATION_LOST     2
#define TWI_NO_CHIP_FOUND        3
#define TWI_RECEIVE_OVERRUN      4
#define TWI_RECEIVE_NACK         5
#define TWI_SEND_OVERRUN         6
#define TWI_SEND_NACK            7
#define TWI_BUSY                 8
#define TWI_ERROR_TIMEOUT        9
#endif

/* Original fan PN (xxx) worked well across any PWM range.
   Due to supply chain issues sub was needed - new fan PN (xxx)
   seems picky and needs almost full on to do anything.
*/
#define MIN_FAN_PWM 95

#define MAX1617_KILL_TEMP 65
#define MAX1617_MAX_TEMP 55
#define MAX1617_FULL_FAN_TEMP 50
#define MAX1617_OFF_FAN_TEMP 35
void pgood_alert_handler(const uint32_t id, const uint32_t index);
void fpga_power_reset_handler(const uint32_t id, const uint32_t index);

int enable_switched_power(void)
{
	gpio_configure_pin(PIN_SAM_SWITCHED_PWR_ENABLE, PIN_SAM_SWITCHED_PWR_ENABLE_FLAGS);
	return 0;
}


int max1617_register_read(uint8_t reg_addr, int8_t *result)
{

	return i2c_read(MAX1617_I2C_ADDR, reg_addr, result, 1);
}

int max1617_register_write(uint8_t reg_addr, int8_t data)
{
	return i2c_write(MAX1617_I2C_ADDR, reg_addr, &data, 1);
}

int power_init(void)
{
	//enable pio falling edge interrupt
	pmc_enable_periph_clk(ID_PIOC);
	pmc_enable_periph_clk(ID_PIOB);
	pio_configure_pin_group(PIN_PGOOD_VCCINT_PORT, PIN_PGOOD_VCCINT_PIN | PIN_PGOOD_1V2_PIN | PIN_PGOOD_1V8_PIN, PIN_PGOOD_VCCINT_FLAGS);
	pio_handler_set(PIN_PGOOD_VCCINT_PORT, ID_PIOC, PIN_PGOOD_VCCINT_PIN | PIN_PGOOD_1V2_PIN | PIN_PGOOD_1V8_PIN, PIO_IT_FALL_EDGE, pgood_alert_handler);
	pio_enable_interrupt(PIN_PGOOD_VCCINT_PORT, PIN_PGOOD_VCCINT_PIN | PIN_PGOOD_1V2_PIN | PIN_PGOOD_1V8_PIN);

	pio_configure_pin_group(PIN_PGOOD_3V3_PORT, PIN_PGOOD_3V3_PIN, PIN_PGOOD_VCCINT_FLAGS);
	pio_handler_set(PIN_PGOOD_3V3_PORT, ID_PIOB, PIN_PGOOD_3V3_PIN, PIO_IT_FALL_EDGE, pgood_alert_handler);
	pio_enable_interrupt(PIN_PGOOD_3V3_PORT, PIN_PGOOD_3V3_PIN);
	NVIC_DisableIRQ(PIOC_IRQn);
	NVIC_ClearPendingIRQ(PIOC_IRQn);
	NVIC_SetPriority(PIOC_IRQn, 9);
	NVIC_EnableIRQ(PIOC_IRQn);
	return 0;
}

int thermals_init(void)
{
	// set conversion rate to 8Hz
	int rtn;

	rtn = max1617_register_write(MAX1617_WRITE_CONV_RATE, 0x07);
	if (rtn != TWI_SUCCESS)
		return rtn;

	// set alert temp to 80 deg C
	rtn = max1617_register_write(MAX1617_WRITE_REMOTE_THIGH, 80);
	if (rtn != TWI_SUCCESS)
		return rtn;

	//setup pins (except I2C)
	gpio_configure_pin(PIN_TEMP_ALERT, PIN_TEMP_ALERT_FLAGS);
	pio_handler_set(PIN_TEMP_ALERT_PORT, ID_PIOA, PIN_TEMP_ALERT_PIN, PIO_IT_FALL_EDGE, max1617_alert_handler);
	pio_enable_interrupt(PIOA, PIN_TEMP_ALERT_PIN);

	gpio_configure_pin(PIN_FPGA_POWER_RESET, PIN_FPGA_POWER_RESET_FLAGS);
	pio_handler_set(PIN_FPGA_POWER_RESET_PORT, ID_PIOB, PIN_FPGA_POWER_RESET_PIN, 0, fpga_power_reset_handler);
	pio_enable_interrupt(PIOB, PIN_FPGA_POWER_RESET_PIN);

	NVIC_EnableIRQ(PIOA_IRQn);
	NVIC_EnableIRQ(PIOB_IRQn);

	gpio_configure_pin(PIN_TEMP_ERR_LED, PIN_TEMP_ERR_LED_FLAGS);
	gpio_configure_pin(PIN_TEMP_OK_LED, PIN_TEMP_OK_LED_FLAGS);
	gpio_configure_pin(PIN_FPGA_PWR_ENABLE, PIN_FPGA_PWR_ENABLE_FLAGS);

	return 0x01;
}


int8_t max1617_read_remote_temp(void)
{
	int8_t temp = 0;
	max1617_register_read(MAX1617_READ_REMOTE_TEMP, &temp);
	return temp;
}

int8_t max1617_read_board_temp(void)
{
	int8_t temp = 0;
	max1617_register_read(MAX1617_READ_LOCAL_TEMP, &temp);
	return temp;
}

//Do all 2s periodic max1617 things (mostly just read temp and go from there)
volatile bool power_killed = false;
volatile int global_fpga_temp = 99;
int thermals_slow_tick(void)
{
	int8_t fpga_temp = 0;
	fpga_temp = max1617_read_remote_temp();

	global_fpga_temp = fpga_temp;


	if (fpga_temp == 0){
		fpga_temp = 200;
	}
	if (fpga_temp >= MAX1617_KILL_TEMP) {
		// kill power, blink red led, green off
		kill_fpga_power();
		power_killed = true;
		gpio_set_pin_low(PIN_TEMP_OK_LED);
		gpio_set_pin_high(PIN_TEMP_ERR_LED);
	} else if (fpga_temp >= MAX1617_MAX_TEMP) {
		if (!power_killed) {
			// red led on, green off, no power kill
		}
		gpio_set_pin_low(PIN_TEMP_OK_LED);
		gpio_set_pin_high(PIN_TEMP_ERR_LED);
	} else { // temp is okay
		gpio_set_pin_high(PIN_TEMP_OK_LED);
		gpio_set_pin_low(PIN_TEMP_ERR_LED);
	}


	fpga_temp = min(MAX1617_FULL_FAN_TEMP, fpga_temp);
	fpga_temp = max(MAX1617_OFF_FAN_TEMP, fpga_temp);

	unsigned int fan_pwm = fpga_temp - MAX1617_OFF_FAN_TEMP;
	fan_pwm = (fan_pwm * 100) /  (MAX1617_FULL_FAN_TEMP-MAX1617_OFF_FAN_TEMP);
	fan_pwm = min(99, fan_pwm);

	if (fan_pwm > 0){
		if (fan_pwm < MIN_FAN_PWM){
			fan_pwm = MIN_FAN_PWM;
		}
	}

	fan_pwm_set_duty_cycle(fan_pwm);


	return 0x00;

}

//blink LED for now
int thermals_fast_tick(void)
{
	if (power_killed) {
		// toggle red LED
		gpio_toggle_pin(PIN_TEMP_ERR_LED);
	}
	return 0x00;
}

void fpga_pins(bool enabled);

void enable_fpga_power(void)
{
	gpio_set_pin_high(PIN_FPGA_PWR_ENABLE);
	fpga_pins(true);
	power_killed = false;
}

void kill_fpga_power(void)
{
	gpio_set_pin_low(PIN_FPGA_PWR_ENABLE);
	fpga_pins(false);
	power_killed = true;

}

void max1617_alert_handler(const uint32_t id, const uint32_t index)
{
	if ((id == ID_PIOA) && (index == PIO_PA16) && (!pio_get(PIOA, PIO_INPUT, PIO_PA16))) {
		// temp too high, kill power
		power_killed = true;
		kill_fpga_power();
	}
}

#define FAN_PWM_TIMER_CHANNEL 0
#define FAN_PWM_FREQ 1000

// Init FPGA Fan at 50% duty cycle
int fan_pwm_init(void)
{
	pmc_enable_periph_clk(ID_TC0);
	tc_init(TC0, FAN_PWM_TIMER_CHANNEL, TC_CMR_TCCLKS_TIMER_CLOCK1 | TC_CMR_WAVE | TC_CMR_ACPA_SET | TC_CMR_ACPC_CLEAR | TC_CMR_CPCTRG);

	uint32_t rc = (sysclk_get_peripheral_bus_hz(TC0) / 128 / FAN_PWM_FREQ); // 178 here is frequency
	uint32_t ra = (100 - 50) * rc / 100; //50 here is duty cycle

	tc_write_rc(TC0, FAN_PWM_TIMER_CHANNEL, rc);
	tc_write_ra(TC0, FAN_PWM_TIMER_CHANNEL, ra);

	tc_start(TC0, FAN_PWM_TIMER_CHANNEL);
	return 0x00;
}

int fan_pwm_set_duty_cycle(uint8_t duty_cycle)
{
	uint32_t rc = (sysclk_get_peripheral_bus_hz(TC0) / 128 / FAN_PWM_FREQ); // 178 here is frequency
	uint32_t ra = (100 - duty_cycle) * rc / 100;

	tc_write_rc(TC0, FAN_PWM_TIMER_CHANNEL, rc);
	tc_write_ra(TC0, FAN_PWM_TIMER_CHANNEL, ra);

	return 0x00;
}

volatile uint8_t power_toggles = 0;
int pgood_tick(void)
{
	power_toggles = 0;
	return 0;
}

void fpga_power_reset_handler(const uint32_t id, const uint32_t index)
{
	if (!pio_get(PIOB, PIO_INPUT, PIN_FPGA_POWER_RESET_PIN)) {
		power_killed = false;
		kill_fpga_power();
	} else {
		enable_fpga_power();
	}
}


int usb_pd_soft_reset(void);
int usb_pd_attached(void);
int usb_pd_update_status(void);
int usb_pd_ov(void);

/*
Can insert regular tasks here if needed
*/
void check_power_state(void)
{
	// TODO: if power killed, maybe ask USB-PD chip if it's getting power
	//Force check on start-up
	static bool last_power_state = true;

	//If change in external state pin
	if (board_get_powerstate() != last_power_state){
		if (board_get_powerstate()){
			//If power turned on, enable all IO to FPGA
			fpga_pins(true);
		} else {
			//If power turned off, disable all IO to FPGA
			fpga_pins(false);
		}

		//Record new state
		last_power_state = board_get_powerstate();
	}
}

void pgood_alert_handler(const uint32_t id, const uint32_t index)
{
	if (pio_get(PIOC, PIO_INPUT, PIN_PGOOD_VCCINT_PIN | PIN_PGOOD_1V2_PIN | PIN_PGOOD_1V8_PIN) != (PIN_PGOOD_VCCINT_PIN | PIN_PGOOD_1V2_PIN | PIN_PGOOD_1V8_PIN) ||
		!pio_get(PIOB, PIO_INPUT, PIN_PGOOD_3V3_PIN))
		if (power_toggles++ > 5) {
			//kill_fpga_power(); //lots of glitching on PIO?
		}
}