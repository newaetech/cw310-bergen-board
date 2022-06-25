/*
 * bergen_usb.c
 *
 * Created: 7/12/2021 8:42:16 PM
 *  Author: adewa
 */ 
#include "naeusb.h"
#include "naeusb_bergen.h"
#include "naeusb_default.h"

int max1617_register_read(uint8_t reg_addr, int8_t *result);

int max1617_register_write(uint8_t reg_addr, int8_t data);
extern volatile uint8_t I2C_STATUS;

twi_package_t USER_TWI_PACKET = {
	.addr = {0x00, 0x00, 0x00},
	.addr_length = 1,
	.chip = 0x00,
	.buffer = NULL,
	.length = 0
};

void ui_powerdown(void)
{
	
}

void ui_wakeup(void)
{
	
}

void ui_process(uint16_t frame_number)
{
	if (!(frame_number % 0x200))
		gpio_toggle_pin(PIN_USB_HBEAT);
}
void ctrl_i2c_send(void)
{
	//heartbleed
	if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size)
	return;
	
	if (I2C_LOCK) {
		I2C_STATUS = 1;
		return;
	}
	
	USER_TWI_PACKET.buffer = udd_g_ctrlreq.payload;
	USER_TWI_PACKET.length = udd_g_ctrlreq.req.wLength;
	I2C_LOCK = 1;
	I2C_STATUS = twi_master_write(TWI0, &USER_TWI_PACKET);
	I2C_LOCK = 0;
}

void ctrl_i2c_setup(void)
{
	if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size)
	return;
	
	uint8_t addr_len = udd_g_ctrlreq.req.wLength - 1;
	if ((addr_len > 3) || (addr_len < 1)) {
		return;
	}
	USER_TWI_PACKET.chip = udd_g_ctrlreq.payload[0];
	for (uint8_t i = 0; i < addr_len; i++) {
		USER_TWI_PACKET.addr[i] = udd_g_ctrlreq.payload[i+1];
	}
	
	
}

void ctrl_fpga_temp_cb(void)
{
	if (I2C_LOCK) {
		I2C_STATUS = 1;
		return;
	}
	I2C_LOCK = 1;
	max1617_register_write(udd_g_ctrlreq.req.wValue & 0xFF, udd_g_ctrlreq.payload[0]);
	I2C_LOCK = 0;
	I2C_STATUS = 0;
}

bool naeusb_cdc_settings_in(void);
bool naeusb_cdc_settings_out(void);

bool bergen_setup_out_received(void)
{
	switch (udd_g_ctrlreq.req.bRequest) {			
		case REQ_FPGA_TEMP:
			udd_g_ctrlreq.callback = ctrl_fpga_temp_cb;
			return true;
			
		case REQ_I2C_SETUP:
			udd_g_ctrlreq.callback = ctrl_i2c_setup;
			return true;
			
		case REQ_I2C_DATA:
			udd_g_ctrlreq.callback = ctrl_i2c_send;
			return true;
			
		case REQ_FPGA_CDC:
			udd_g_ctrlreq.callback = naeusb_cdc_settings_out;
			return true;
			break;
	}
	return false;
}

bool bergen_setup_in_received(void)
{
	uint8_t addr;
	switch (udd_g_ctrlreq.req.bRequest & 0xFF) {
		case REQ_FPGA_TEMP:
			addr = udd_g_ctrlreq.req.wValue & 0xFF;
			if (I2C_LOCK) {
				respbuf[0] = 1;
				udd_g_ctrlreq.payload = respbuf;
				udd_g_ctrlreq.payload_size = 1;
				return true;
			}
			max1617_register_read(addr, respbuf + 1);
			respbuf[0] = 0;
			udd_g_ctrlreq.payload = respbuf;
			udd_g_ctrlreq.payload_size = 2;
			return true;
			break;

		case REQ_I2C_SETUP:
			respbuf[0] = I2C_STATUS;
			respbuf[1] = USER_TWI_PACKET.chip;
			for (uint8_t i = 0; i < USER_TWI_PACKET.addr_length; i++) {
				respbuf[i + 2] = USER_TWI_PACKET.addr[i];
			}
			udd_g_ctrlreq.payload = respbuf;
			udd_g_ctrlreq.payload_size = USER_TWI_PACKET.addr_length + 2;
			return true;
			break;
		
		case REQ_I2C_DATA:
			USER_TWI_PACKET.length = udd_g_ctrlreq.req.wLength;
			USER_TWI_PACKET.buffer = respbuf + 1;
			if (I2C_LOCK) {
				respbuf[0] = 1;
				I2C_STATUS = 1;
				udd_g_ctrlreq.payload = respbuf;
				udd_g_ctrlreq.payload_size = USER_TWI_PACKET.length + 1;
				return true;
			}
			
			I2C_LOCK = 1;
			twi_master_read(TWI0, &USER_TWI_PACKET);
			respbuf[0] = 0;
			I2C_LOCK = 0;
			udd_g_ctrlreq.payload = respbuf;
			udd_g_ctrlreq.payload_size = USER_TWI_PACKET.length + 1;
			return true;
			break;
		case REQ_FPGA_CDC:
			return naeusb_cdc_settings_in();
			break;
	}
	return false;
}

void bergen_register_handlers(void)
{
	naeusb_add_in_handler(bergen_setup_in_received);
	naeusb_add_out_handler(bergen_setup_out_received);
}