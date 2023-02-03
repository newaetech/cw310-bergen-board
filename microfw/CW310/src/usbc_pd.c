#include <asf.h>


static uint8_t usb_pd_status[10] = {0};
static uint8_t usb_pd_rdo_status[4] = {0};
int usb_pd_update_status(void)
{
	twi_package_t packet_begin = {
			.addr = {0x0D, 0, 0},
			.addr_length = 1,
			.chip = 0x28,
			.buffer = usb_pd_status,
			.length = 10
	};
	if (I2C_LOCK)
		return -1;
	I2C_LOCK = 1;
	
	if (twi_master_read(TWI0, &packet_begin) != TWI_SUCCESS) {
		return -1;
	}
	twi_package_t packet_rdo = {
			.addr = {0x91, 0, 0},
			.addr_length = 1,
			.chip = 0x28,
			.buffer = usb_pd_rdo_status,
			.length = 4
	};
	if (twi_master_read(TWI0, &packet_rdo) != TWI_SUCCESS) {
		return -1;
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
int usb_pd_soft_reset(void)
{
	if (I2C_LOCK)
		return -1;
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
	
	return 0;
}