#include <asf.h>
#include "i2c_util.h"

#define USB_PD_ADDR 0x28

static uint8_t usb_pd_status[10] = {0};
static uint8_t usb_pd_rdo_status[4] = {0};
int usb_pd_update_status(void)
{
	int rtn = 0;
	if (rtn = i2c_write(USB_PD_ADDR, 0x0D, usb_pd_status, 10), rtn) {
		return rtn;
	}

	if (rtn = i2c_write(USB_PD_ADDR, 0x91, usb_pd_rdo_status, 4), rtn) {
		return rtn;
	}
	return 0;
}

// 0 if not attached, 1 if attached
// int usb_pd_attached(void)
// {
// 	uint8_t status = 0;
// 	twi_package_t packet_begin = {
// 			.addr = {0x0E, 0, 0},
// 			.addr_length = 1,
// 			.chip = 0x28,
// 			.buffer = &status,
// 			.length = 1
// 	};

// 	if (I2C_LOCK)
// 		return -1;
// 	I2C_LOCK = 1;
	
// 	if (twi_master_read(TWI0, &packet_begin) != TWI_SUCCESS) {
// 		return 0;
// 	}

// 	if (status & 0x01) {
// 		return 1;
// 	} else {
// 		return 0;
// 	}

// }

/*
Setup st USBC power chip to accept 20V 5A, 
*/
void usb_pwr_setup(void)
{
	// set pdo2 to 20V
	//starts from 0 address?
	uint32_t req_voltage = 1; //(12/0.05);
	uint8_t status[10] = {0};

	int rtn = 0;
	if (i2c_read(USB_PD_ADDR, 0x0D, status, 10)) {
		return;
	}

	req_voltage = 0;

	// read current voltage
	if (i2c_read(USB_PD_ADDR, 0x89, &req_voltage, 4)) {
		return;
	}

	req_voltage &= ~(0x3FF);
	req_voltage |= (100);

	if (i2c_write(USB_PD_ADDR, 0x89, &req_voltage, 4)) {
		return;
	}

	// idk...
	if (i2c_read(USB_PD_ADDR, 0x89, &req_voltage, 4)) {
		return;
	}
	// // old code
	// twi_package_t packet_begin = {
	// 		.addr = {0x0D, 0, 0},
	// 		.addr_length = 1,
	// 		.chip = 0x28,
	// 		.buffer = status,
	// 		.length = 10
	// };
	// if (I2C_LOCK)
	// 	return;
	// I2C_LOCK = 1;
	
	// if (twi_master_read(TWI0, &packet_begin) != TWI_SUCCESS) {
	// 	req_voltage = 0;
	// }
	// twi_package_t packet_read_voltage = {
	// 	.addr = {0x89, 0, 0},
	// 	.addr_length = 1,
	// 	.chip = 0x28,
	// 	.buffer = &req_voltage,
	// 	.length = 4
	// };
	
	// if (twi_master_read(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
	// 	req_voltage = 0;
	// }
	
	// req_voltage &= ~(0x3FF);
	// req_voltage |= (100);
	
	// if (twi_master_write(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
	// 	req_voltage = 0;
	// }
		
	// if (twi_master_read(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
	// 	req_voltage = 0;
	// }
	// I2C_LOCK = 0;
}

/*
Get USBC Power Chip to renegotiate power with power brick

Must be done after setting new power settings
*/
int usb_pd_soft_reset(void)
{
	if (I2C_LOCK)
		return -1;
	I2C_LOCK = 1;
	uint8_t cmd = 0x0D;
	int rtn;

	if (rtn = i2c_write(USB_PD_ADDR, 0x51, &cmd, 1), rtn) {
		return rtn;
	}

	cmd = 0x26;
	if (rtn = i2c_write(USB_PD_ADDR, 0x1A, &cmd, 1), rtn) {
		return rtn;
	}

	uint32_t req_voltage = 1;

	if (rtn = i2c_read(USB_PD_ADDR, 0x89, &req_voltage, 4), rtn) {
		return rtn;
	}
	return 0;

	//old code
	// twi_package_t packet_soft_reset = {
	// 	.addr = {0x51, 0, 0},
	// 	.addr_length = 1,
	// 	.chip = 0x28,
	// 	.buffer = &cmd,
	// 	.length = 1
	// };
	
	
	// if (twi_master_write(TWI0, &packet_soft_reset) != TWI_SUCCESS) {
	// 	I2C_LOCK = 0;
	// 	return -1;
	// }
	
	// uint8_t send_cmd = 0x26;
	// twi_package_t packet_send_cmd = {
	// 	.addr = {0x1A, 0, 0},
	// 	.addr_length = 1,
	// 	.chip = 0x28,
	// 	.buffer = &send_cmd,
	// 	.length = 1
	// };
	
	// uint32_t req_voltage = 1; //(12/0.05);
	
	// if (twi_master_write(TWI0, &packet_send_cmd) != TWI_SUCCESS) {
	// 	I2C_LOCK = 0;
	// 	return -1;
	// }
	
	// twi_package_t packet_read_voltage = {
	// 	.addr = {0x89, 0, 0},
	// 	.addr_length = 1,
	// 	.chip = 0x28,
	// 	.buffer = &req_voltage,
	// 	.length = 4
	// };
	
	// if (twi_master_read(TWI0, &packet_read_voltage) != TWI_SUCCESS) {
	// 	req_voltage = 0;
	// }
	// I2C_LOCK = 0;
	
	// return 0;
}