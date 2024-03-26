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
}

/*
Get USBC Power Chip to renegotiate power with power brick

Must be done after setting new power settings
*/
int usb_pd_soft_reset(void)
{
	if (i2c_is_locked())
		return -1;

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

}