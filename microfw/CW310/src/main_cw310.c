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
#include "usb.h"
#include "tps56520.h"
#include "cdce906.h"
#include "timers.h"
#include "thermal_power.h"
#include "naeusb_bergen.h"

#include "naeusb/naeusb_default.h"
#include "naeusb/naeusb_usart.h"
#include "naeusb/naeusb_fpga_target.h"
#include <string.h>


//Serial Number - will be read by device ID
char usb_serial_number[33] = "000000000000DEADBEEF";

void fpga_pins(bool enabled);
int usb_pd_soft_reset(void);
void usb_pwr_setup(void);
void check_power_state(void);

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
		gpio_configure_pin(PIN_EBI_NRD, PIN_EBI_NRD_FLAGS);
		gpio_configure_pin(PIN_EBI_NWE, PIN_EBI_NWE_FLAGS);
		gpio_configure_pin(PIN_EBI_NCS0, PIN_EBI_NCS0_FLAGS);
			
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A0, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A1, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A2, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A3, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A4, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A5, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A6, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A7, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A8, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A9, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A10, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A11, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A12, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A13, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A14, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A15, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A16, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A17, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A18, PIN_EBI_DATA_BUS_FLAG1);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A19, PIN_EBI_DATA_BUS_FLAG1);
		//gpio_configure_pin(PIN_EBI_ADDR_BUS_A20, PIN_EBI_DATA_BUS_FLAG1); /* TODO: Add ADDR20 back */
		
		
		/* FPGA Programming pins */
		FPGA_NPROG_SETUP();
		FPGA_NPROG_HIGH();		
			
		/* FPGA External memory interface */
		//Allow sync writing to address pins
		//gpio_configure_group(FPGA_ADDR_PORT, FPGA_ADDR_PINS, (PIO_TYPE_PIO_OUTPUT_0 | PIO_DEFAULT));
		//pio_enable_output_write(FPGA_ADDR_PORT, FPGA_ADDR_PINS);
			
		//ALE pin under SW control
		//gpio_configure_pin(FPGA_ALE_GPIO, FPGA_ALE_FLAGS);
		//gpio_set_pin_high(FPGA_ALE_GPIO);
			
		//Force FPGA trigger
		
		gpio_configure_pin(FPGA_TRIGGER_GPIO, FPGA_TRIGGER_FLAGS);
		
		gpio_configure_pin(PIN_FPGA_PROGRAM_GPIO, PIN_FPGA_PROGRAM_FLAGS);
		
		//gpio_configure_pin(SPI_MISO_GPIO, SPI_MISO_FLAGS); /* TODO: Add back */
		//gpio_configure_pin(SPI_MOSI_GPIO, SPI_MOSI_FLAGS); /* TODO: Add back */
		//gpio_configure_pin(SPI_SPCK_GPIO, SPI_SPCK_FLAGS); /* TODO: Add back */

	} else {
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
		gpio_configure_pin(PIN_EBI_NRD, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_NWE, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_NCS0, PIO_INPUT);
		
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A0, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A1, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A2, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A3, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A4, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A5, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A6, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A7, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A8, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A9, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A10, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A11, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A12, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A13, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A14, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A15, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A16, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A17, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A18, PIO_INPUT);
		gpio_configure_pin(PIN_EBI_ADDR_BUS_A19, PIO_INPUT);
		//gpio_configure_pin(PIN_EBI_ADDR_BUS_A20, PIO_INPUT);	
			
		/* FPGA External memory interface */
		//Allow sync writing to address pins
		//gpio_configure_group(FPGA_ADDR_PORT, FPGA_ADDR_PINS, PIO_INPUT);
		
		//ALE pin under SW control
		//gpio_configure_pin(FPGA_ALE_GPIO, PIO_INPUT);
		
		//Force FPGA trigger
		gpio_configure_pin(FPGA_TRIGGER_GPIO, PIO_INPUT);
		
		gpio_configure_pin(PIN_FPGA_PROGRAM_GPIO, PIO_INPUT);
		
		gpio_configure_pin(SPI_MISO_GPIO, PIO_INPUT); /* TODO: Add back */
		gpio_configure_pin(SPI_MOSI_GPIO, PIO_INPUT); /* TODO: Add back */
		gpio_configure_pin(SPI_SPCK_GPIO, PIO_INPUT); /* TODO: Add back */
	}
	
	gpio_configure_pin(PIN_FPGA_DONE_GPIO, PIN_FPGA_DONE_FLAGS);
	
}

/*
Setup st USBC power chip to accept 20V 5A, 
*/
void usb_pwr_setup()
{// set pdo2 to 20V
	//starts from 0 address?
	uint32_t req_voltage = 1; //(12/0.05);
	uint8_t status[10] = {0};
	twi_package_t packet_begin = {
			.addr = {0x0D, 0, 0},
			.addr_length = 1,
			.chip = 0x28,
			.buffer = status,
			.length = 10
	};
	if (I2C_LOCK)
		return;
	I2C_LOCK = 1;
	
	if (twi_master_read(TWI0, &packet_begin) != TWI_SUCCESS) {
		req_voltage = 0;
	}
	twi_package_t packet_read_voltage = {
		.addr = {0x89, 0, 0},
		.addr_length = 1,
		.chip = 0x28,
		.buffer = &req_voltage,
		.length = 4
	};
	
	if (twi_master_read(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
		req_voltage = 0;
	}
	
	req_voltage &= ~(0x3FF);
	req_voltage |= (100);
	
	if (twi_master_write(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
		req_voltage = 0;
	}
		
	if (twi_master_read(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
		req_voltage = 0;
	}
	I2C_LOCK = 0;
}

/*
Get USBC Power Chip to renegotiate power with power brick

Must be done after setting new power settings
*/
int usb_pd_soft_reset()
{
	if (I2C_LOCK)
		return;
	I2C_LOCK = 1;
	uint8_t cmd = 0x0D;
	twi_package_t packet_soft_reset = {
		.addr = {0x51, 0, 0},
		.addr_length = 1,
		.chip = 0x28,
		.buffer = &cmd,
		.length = 1
	};
	
	
	if (twi_master_write(TWI0, &packet_soft_reset) != TWI_SUCCESS) {
		I2C_LOCK = 0;
		return -1;
	}
	
	uint8_t send_cmd = 0x26;
	twi_package_t packet_send_cmd = {
		.addr = {0x1A, 0, 0},
		.addr_length = 1,
		.chip = 0x28,
		.buffer = &send_cmd,
		.length = 1
	};
	
	uint32_t req_voltage = 1; //(12/0.05);
	
	if (twi_master_write(TWI0, &packet_send_cmd) != TWI_SUCCESS) {
		I2C_LOCK = 0;
		return -1;
	}
	
	twi_package_t packet_read_voltage = {
		.addr = {0x89, 0, 0},
		.addr_length = 1,
		.chip = 0x28,
		.buffer = &req_voltage,
		.length = 4
	};
	
	if (twi_master_read(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
		req_voltage = 0;
	}
	I2C_LOCK = 0;
	
	return 5;
}


/*! \brief Main function. Execution starts here.
 */
int main(void)
{
	volatile uint32_t reset_reason = 0;
	I2C_LOCK = 0;
	
	// capture reset reason as watchdog on by default...
	reset_reason = RSTC->RSTC_SR;
	reset_reason = reset_reason; //Still a thing in 2021??
	uint32_t serial_number[4];
	
	//disable watchdog
	WDT->WDT_MR = (1 << 25);
	
	//Fan on for now - will switch to PWM later.
	gpio_configure_pin(PIO_PB25_IDX, PIO_TYPE_PIO_OUTPUT_1);
	
	flash_read_unique_id(serial_number, sizeof(serial_number));
	
	ioport_init();
	enable_switched_power();
		
	irq_initialize_vectors();
	cpu_irq_enable();
		
	// Let power come up
	delay_ms(25);
	
	//Detect state of switch
	gpio_configure_pin(PIN_SWSTATE_GPIO, PIN_SWSTATE_FLAGS);
	gpio_configure_pin(PIN_USB_HBEAT, PIN_USB_HBEAT_FLAGS);
	
	// USB-PD Chip reset - must be done before configuring 
	gpio_configure_pin(PIN_USB_RESET, PIO_TYPE_PIO_OUTPUT_0);
	gpio_set_pin_high(PIN_USB_RESET);
	
	// Initialize the sleep manager
	sleepmgr_init();
	irq_initialize_vectors();
#if !SAMD21 && !SAMR21
	sysclk_init();
	board_init();
#else
	system_init();
#endif

	tps56520_init();
	gpio_set_pin_low(PIN_USB_RESET);
	
	//Init CDCE906 Chip
	cdce906_init();
	
	// usbc PD chip needs more time?
	delay_ms(25); //TODO - these delays are way off??
	
	// setup usbc power
	usb_pwr_setup();
	usb_pd_soft_reset();

	//Convert serial number to ASCII for USB Serial number
		//Convert serial number to ASCII for USB Serial number
	for(unsigned int i = 0; i < 4; i++){
		sprintf(usb_serial_number+(i*8), "%08x", (unsigned int)serial_number[i]);
	}
	usb_serial_number[32] = 0;

	/* Enable SMC */
	pmc_enable_periph_clk(ID_SMC);	
	fpga_pins(true);
	
	/* Configure EBI I/O for PSRAM connection */
	printf("Setting up FPGA Communication\n");
	
	//The Read Cycle = NCS_RD_SETUP + NCS_RD_PULSE + NCS_RD_HOLD
	//But you can't define things invalid, so hold is auto-calculated:	
	//NRD_HOLD = NRD_CYCLE - NRD SETUP - NRD PULSE
	//NCS_RD_HOLD = NRD_CYCLE - NCS_RD_SETUP - NCS_RD_PULSE
	
	/* complete SMC configuration between PSRAM and SMC waveforms. */
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
	
	
	//Fan output pin
	gpio_configure_pin(PIO_PB25_IDX, PIO_PERIPH_B);	
	
	fan_pwm_init();
	fan_pwm_set_duty_cycle(75); //Set at 50% in case we crash - will be tuned later
	power_init();
	
	//Following is 60MHz version
	//genclk_enable_config(GENCLK_PCK_0, GENCLK_PCK_SRC_PLLBCK, GENCLK_PCK_PRES_4);
	thermals_init();
	periodic_timer_init();
	udc_start();
	
	
	gpio_configure_pin(PIO_PB27_IDX, PIO_OUTPUT_1 | PIO_DEFAULT);
	enable_fpga_power();
	naeusb_register_handlers();
	naeusart_register_handlers();
	fpga_target_register_handlers();
	bergen_register_handlers();
	
	// send received USART data over to PC on cdc 0 and 1
	while (true) {
		
		check_power_state(); //make sure power hasn't been killed		
	}
}

