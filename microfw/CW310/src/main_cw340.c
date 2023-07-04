/*
 Copyright (c) 2015-2016 NewAE Technology Inc. All rights reserved.

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <asf.h>
#include "conf_usb.h"
#include "ui.h"
#include "genclk.h"
#include "fpga_program.h"
#include "usart_driver.h"
#include "tasks.h"
#include "usb_xmem.h"
#include "naeusb/tps56520.h"
#include "naeusb/cdce906.h"
#include "timers.h"
#include "thermal_power.h"
#include "naeusb_bergen.h"
#include "naeusb_luna.h"
#include "usbc_pd.h"
#include "i2c_util.h"

#include "VFD_display.h"

#include "naeusb/naeusb_default.h"
#include "naeusb/naeusb_usart.h"
#include "naeusb/naeusb_fpga_target.h"
#include <string.h>


//Serial Number - will be read by device ID
char usb_serial_number[33] = "000000000000DEADBEEF";

extern volatile int global_fpga_temp;

void fpga_pins(bool enabled);
void usb_pwr_setup(void);
void check_power_state(void);

/*
If enabled, configure FPGA pins as their default

If not enabled, high-z FPGA pins to avoid powering FPGA thru them
*/
void fpga_pins(bool enabled)
{
	gpio_configure_pin(PIN_FPGA_DONE_GPIO, PIN_FPGA_DONE_FLAGS);

	//gpio_configure_pin(PIO_PB22_IDX, PIO_OUTPUT_0);
	//gpio_configure_pin(PIO_PB18_IDX, PIO_OUTPUT_0);

	if (enabled){
		#ifdef CONF_BOARD_PCK0
		gpio_configure_pin(PIN_PCK0, PIN_PCK0_FLAGS);
		#endif

		#ifdef CONF_BOARD_PCK1
		gpio_configure_pin(PIN_PCK1, PIN_PCK1_FLAGS);
		#endif


		gpio_configure_pin(PIN_USART0_RXD, PIN_USART0_RXD_FLAGS);
		gpio_configure_pin(PIN_USART0_TXD, PIN_USART0_TXD_FLAGS);
		gpio_configure_pin(PIN_USART1_RXD, PIN_USART1_RXD_FLAGS);
		gpio_configure_pin(PIN_USART1_TXD, PIN_USART1_TXD_FLAGS);

		gpio_configure_pin(PIN_EBI_DATA_BUS_D0, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D1, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D2, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D3, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D4, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D5, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D6, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D7, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D8, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D9, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D10, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D11, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D12, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D13, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D14, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D15, PIN_EBI_DATA_BUS_FLAG1);

		gpio_configure_pin(PIN_EBI_NRD, PIN_EBI_NRD_FLAGS);
		gpio_configure_pin(PIN_EBI_NWE, PIN_EBI_NWE_FLAGS);
		gpio_configure_pin(PIN_EBI_NCS0, PIN_EBI_NCS0_FLAGS);
		gpio_configure_pin(FPGA_ALE_GPIO, FPGA_ALE_FLAGS);

		/* FPGA Programming pins */
		FPGA_NPROG_SETUP();
		FPGA_NPROG_HIGH();


		gpio_configure_pin(FPGA_TRIGGER_GPIO, FPGA_TRIGGER_FLAGS);

		gpio_configure_pin(PIN_FPGA_PROGRAM_GPIO, PIN_FPGA_PROGRAM_FLAGS);

		//gpio_configure_pin(SPI_MISO_GPIO, SPI_MISO_FLAGS); /* TODO: Add back */
		//gpio_configure_pin(SPI_MOSI_GPIO, SPI_MOSI_FLAGS); /* TODO: Add back */
		//gpio_configure_pin(SPI_SPCK_GPIO, SPI_SPCK_FLAGS); /* TODO: Add back */

	} else {
		// high-z FPGA pins to avoid powering the FPGA thru these pins
		#ifdef CONF_BOARD_PCK0
		gpio_configure_pin(PIN_PCK0, PIO_INPUT);
		#endif

		#ifdef CONF_BOARD_PCK1
		gpio_configure_pin(PIN_PCK1, PIO_INPUT);
		#endif

		gpio_configure_pin(PIN_USART0_RXD, PIO_INPUT);
		gpio_configure_pin(PIN_USART0_TXD, PIO_INPUT);
		gpio_configure_pin(PIN_USART1_RXD, PIO_INPUT);
		gpio_configure_pin(PIN_USART1_TXD, PIO_INPUT);

		gpio_configure_pin(PIN_EBI_DATA_BUS_D0, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D1, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D2, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D3, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D4, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D5, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D6, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D7, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D8,  PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D9,  PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D10, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D11, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D12, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D13, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D14, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_DATA_BUS_D15, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_NRD, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_NWE, PIO_OUTPUT_0);
		gpio_configure_pin(PIN_EBI_NCS0, PIO_INPUT);
		gpio_configure_pin(FPGA_ALE_GPIO, PIO_INPUT);

		//Force FPGA trigger
		gpio_configure_pin(FPGA_TRIGGER_GPIO, PIO_INPUT);

		gpio_configure_pin(PIN_FPGA_PROGRAM_GPIO, PIO_INPUT);

		gpio_configure_pin(SPI_MISO_GPIO, PIO_INPUT); /* TODO: Add back */
		gpio_configure_pin(SPI_MOSI_GPIO, PIO_INPUT); /* TODO: Add back */
		gpio_configure_pin(SPI_SPCK_GPIO, PIO_INPUT); /* TODO: Add back */
	}

	gpio_configure_pin(PIN_FPGA_DONE_GPIO, PIN_FPGA_DONE_FLAGS);

}

#define TPS56520_ADDR 0x34

void peripheral_setup(void)
{
	ioport_init(); //enable IO clocks

	fpga_pins(0); // set FPGA pins as inputs

	enable_switched_power();

	// Let power come up
	// delay_ms(25);

	// Set enabled detection pin for switching regulator to input
	gpio_configure_pin(PIN_SWSTATE_GPIO, PIN_SWSTATE_FLAGS);

	// Turn on USB heartbeat pin
	gpio_configure_pin(PIN_USB_HBEAT, PIN_USB_HBEAT_FLAGS);

	// enable temp LED GPIOs
	gpio_configure_pin(PIN_TEMP_ERR_LED, PIN_TEMP_ERR_LED_FLAGS);
	gpio_configure_pin(PIN_TEMP_OK_LED, PIN_TEMP_OK_LED_FLAGS);

	irq_initialize_vectors();
	cpu_irq_enable();

	// Initialize the sleep manager
	sleepmgr_init();

#if !SAMD21 && !SAMR21
	sysclk_init();
	board_init();
#else
	system_init();
#endif
	i2c_setup(); // setup I2C comms


	/* complete SMC configuration between PSRAM and SMC waveforms. */
	//The Read Cycle = NCS_RD_SETUP + NCS_RD_PULSE + NCS_RD_HOLD
	//But you can't define things invalid, so hold is auto-calculated:
	//NRD_HOLD = NRD_CYCLE - NRD SETUP - NRD PULSE
	//NCS_RD_HOLD = NRD_CYCLE - NCS_RD_SETUP - NCS_RD_PULSE
	
	// NOTE: This stuff gets changed during parallel programming, check that it gets set back to the way it was

	pmc_enable_periph_clk(ID_SMC);
	smc_set_setup_timing(SMC, 0, SMC_SETUP_NWE_SETUP(2)
	| SMC_SETUP_NCS_WR_SETUP(3)
	| SMC_SETUP_NRD_SETUP(2)
	| SMC_SETUP_NCS_RD_SETUP(3));
	smc_set_pulse_timing(SMC, 0, SMC_PULSE_NWE_PULSE(6)
	| SMC_PULSE_NCS_WR_PULSE(2)
	| SMC_PULSE_NRD_PULSE(6)
	| SMC_PULSE_NCS_RD_PULSE(6));
	smc_set_cycle_timing(SMC, 0, SMC_CYCLE_NWE_CYCLE(12)
	| SMC_CYCLE_NRD_CYCLE(12));
	smc_set_mode(SMC, 0, SMC_MODE_READ_MODE | SMC_MODE_WRITE_MODE
        | SMC_MODE_DBW_BIT_8);


	/* Enable PCLK0 at 84 MHz */
	genclk_enable_config(GENCLK_PCK_0, GENCLK_PCK_SRC_MCK, GENCLK_PCK_PRES_1);
	pmc_enable_upll_clock();
	pmc_enable_periph_clk(ID_UOTGHS);

	// Setup fan PWM
	gpio_configure_pin(PIO_PB25_IDX, PIO_PERIPH_B);

	fan_pwm_init();
	fan_pwm_set_duty_cycle(75); //Set at 50% in case we crash - will be tuned later

	// tps56520_init(); // set FPGA voltage to default (1V) //do later, after daughter board connected
	cdce906_init();  //Init CDCE906 PLL Chip

	// turn on power pins for various on board regulators
	power_init();

	// enable on board thermometers for monitoring board temps
	thermals_init();

	/* Enable SMC */
	fpga_pins(true);

	// init VFD Display
	GU7000_init();

	// Start USB
	udc_start();

	// enable periodic interrupt to check thermals
	periodic_timer_init();

	// enable power delivery to FPGA (Tgt Power switch)
	gpio_configure_pin(PIO_PB27_IDX, PIO_OUTPUT_1 | PIO_DEFAULT);

	enable_fpga_power();

	// FPGA Mode pins setup
	gpio_configure_pin(PIN_FPGA_M0, PIN_FPGA_M0_FLAGS);
	gpio_configure_pin(PIN_FPGA_M1, PIN_FPGA_M1_FLAGS);
	gpio_configure_pin(PIN_FPGA_M2, PIN_FPGA_M2_FLAGS);

	gpio_configure_pin(PIN_VBUS_DETECT, PIN_VBUS_DETECT_FLAGS);
}

/*! \brief Main function. Execution starts here.
 */
int main(void)
{
	volatile uint32_t reset_reason = 0;

	// capture reset reason as watchdog on by default...
	reset_reason = RSTC->RSTC_SR;
	reset_reason = reset_reason; //Still a thing in 2021??
	WDT->WDT_MR = (1 << 25); //disable watchdog

	// unlock I2C
	I2C_LOCK = 0;

	//Convert serial number to ASCII for USB Serial number
	uint32_t serial_number[4];
	flash_read_unique_id(serial_number, sizeof(serial_number));
	for(unsigned int i = 0; i < 4; i++){
		sprintf(usb_serial_number+(i*8), "%08x", (unsigned int)serial_number[i]);
	}
	usb_serial_number[32] = 0;

	peripheral_setup(); // turn on required peripherals

	// register handlers for USB requests
	naeusb_register_handlers();
	naeusart_register_handlers();
	fpga_target_register_handlers();
	bergen_register_handlers();
	luna_register_handlers();
    gpio_configure_pin(PIN_EBI_NWE, PIO_OUTPUT_0);

	delay_ms(500);
	//GU7000_cursorOn();

	/* 16x16 image "opentitan_icon" */
	static const uint8_t image_opentitan_icon[] = {
		0xf9,0x9f,0xf9,0x9f,0xc1,0x83,0xc1,0x83,0xc1,0x83,0x07,0xe0,0x04,0x20,0xfc,0x3f,
		0xfc,0x3f,0x04,0x20,0x07,0xe0,0xc1,0x83,0xc1,0x83,0xc1,0x83,0xf9,0x9f,0xf9,0x9f
	};
	GU7000_drawImage_ram(16, 16, image_opentitan_icon);

    GU7000_defineWindow(1, 17, 0, 112-17, 16);
	GU7000_selectWindow(1);

	GU7000_setFontSize(1, 1, false);
	GU7000_setFontStyle(true, false);
	vfd_write("Luna Board\n\r");
	
	static int last_fpga_temp;
	char sbuf[20];


	// send received USART data over to PC on cdc 0 and 1
	while (true) {

		/*TODO - vfd write uses polling so locks up CPU. Should do interrupt-based. */
		if(global_fpga_temp != last_fpga_temp){
			last_fpga_temp = global_fpga_temp;
			GU7000_setCursor(0, 8);
			itoa(last_fpga_temp, sbuf, 10);
			vfd_write(sbuf);
			vfd_write(" C ");
		}
		cdc_send_to_pc();
		check_power_state(); //make sure power hasn't been killed
		if (!TPS_CONNECTED) {
			if (tps56520_set(600)) {
				if (tps56520_set(950)) {
					TPS_CONNECTED = true;
				}
			}
		}
	}
}

