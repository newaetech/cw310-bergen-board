/*
 * naeusb_bergen.h
 *
 * Created: 7/12/2021 8:42:43 PM
 *  Author: adewa
 */ 


#ifndef NAEUSB_BERGEN_H_
#define NAEUSB_BERGEN_H_

#define REQ_FPGA_CDC 0x41
#define REQ_FPGA_TEMP 0x42

#define REQ_I2C_SETUP 0x43
#define REQ_I2C_DATA 0x44

// 0x4A+ reserved for Luna board


void bergen_register_handlers(void);


#endif /* NAEUSB_BERGEN_H_ */