/*
   Copyright (c) 2014-2020 NewAE Technology Inc. All rights reserved.

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
#include "fpgaspi_program.h"
#include "fpgautil_io.h"
#include "usart_driver.h"
#include "usb.h"
#include "fpga_xmem.h"
#include "cdce906.h"
#include "tps56520.h"
#include "thermal_power.h"
#include <string.h>

#define FW_VER_MAJOR 0
#define FW_VER_MINOR 40
#define FW_VER_DEBUG 1
twi_package_t USER_TWI_PACKET = {
		.addr = {0x00, 0x00, 0x00},
		.addr_length = 1,
		.chip = 0x00,
		.buffer = NULL,
		.length = 0
};

volatile bool g_captureinprogress = true;

static volatile bool main_b_vendor_enable = true;

COMPILER_WORD_ALIGNED
static uint8_t main_buf_loopback[MAIN_LOOPBACK_SIZE];
static volatile bool cdc_settings_change[2] = {true, true};

void main_vendor_bulk_in_received(udd_ep_status_t status,
        iram_size_t nb_transfered, udd_ep_id_t ep);
void main_vendor_bulk_out_received(udd_ep_status_t status,
        iram_size_t nb_transfered, udd_ep_id_t ep);
		
int max1617_register_read(uint8_t reg_addr, int8_t *result);

int max1617_register_write(uint8_t reg_addr, int8_t data);

void main_suspend_action(void)
{
   // ui_powerdown();
}

void main_resume_action(void)
{
    //ui_wakeup();
}

void main_sof_action(void)
{
    if (!main_b_vendor_enable)
        return;
	
	if (!(udd_get_frame_number() % 0x200))
		gpio_toggle_pin(PIN_USB_HBEAT);
   // ui_process(udd_get_frame_number());
}

bool main_vendor_enable(void)
{
    main_b_vendor_enable = true;
    // Start data reception on OUT endpoints
#if UDI_VENDOR_EPS_SIZE_BULK_FS
    //main_vendor_bulk_in_received(UDD_EP_TRANSFER_OK, 0, 0);
    udi_vendor_bulk_out_run(
            main_buf_loopback,
            sizeof(main_buf_loopback),
            main_vendor_bulk_out_received);
#endif
    return true;
}

void main_vendor_disable(void)
{
    main_b_vendor_enable = false;
}

/* Read/write into FPGA memory-mapped space */
#define REQ_MEMREAD_BULK 0x10
#define REQ_MEMWRITE_BULK 0x11
#define REQ_MEMREAD_CTRL 0x12
#define REQ_MEMWRITE_CTRL 0x13
#define REQ_MEMWRITE_CTRL_SAMU3 0x15

/* Get status of INITB and PROG lines */
#define REQ_FPGA_STATUS 0x15

/* Enter FPGA Programming mode */
#define REQ_FPGA_PROGRAM 0x16

/* Get SAM3U Firmware Version */
#define REQ_FW_VERSION 0x17

/* Program XMEGA (DMM volt-meter) */
#define REQ_XMEGA_PROGRAM 0x20

/* Various Settings */
#define REQ_SAM3U_CFG 0x22

/* Send data to PLL chip */
#define REQ_CDCE906 0x30

/* Set VCC-INT Voltage */
#define REQ_VCCINT 0x31

/* Send SPI commands to chip on FPGA */
#define REQ_FPGASPI_PROGRAM 0x33

/* Configure IO */
#define REQ_FPGAIO_UTIL 0x34

/* SPI1 Utility */
#define FREQ_FPGASPI1_XFER 0x35

#define REQ_CDC_SETTINGS_EN 0x41

#define REQ_FPGA_TEMP 0x42

#define REQ_I2C_SETUP 0x43
#define REQ_I2C_DATA 0x44

void ctrl_i2c_send(void)
{
	//heartbleed
	if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size)
		return;
	
	USER_TWI_PACKET.buffer = udd_g_ctrlreq.payload;
	USER_TWI_PACKET.length = udd_g_ctrlreq.req.wLength;
	twi_master_write(TWI0, &USER_TWI_PACKET);
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


COMPILER_WORD_ALIGNED static uint8_t ctrlbuffer[64];
#define CTRLBUFFER_WORDPTR ((uint32_t *) ((void *)ctrlbuffer))

typedef enum {
    bep_emem=0,
    bep_fpgabitstream=10
} blockep_usage_t;

static blockep_usage_t blockendpoint_usage = bep_emem;

static uint8_t * ctrlmemread_buf;
static unsigned int ctrlmemread_size;

void ctrl_readmem_bulk(void);
void ctrl_readmem_ctrl(void);
void ctrl_writemem_bulk(void);
void ctrl_writemem_ctrl(void);
void ctrl_writemem_ctrl_sam3u(void);
void ctrl_progfpga_bulk(void);
bool ctrl_xmega_program(void);
void ctrl_xmega_program_void(void);

uint32_t sam3u_mem[256];

void ctrl_xmega_program_void(void)
{
}

void ctrl_readmem_bulk(void){
    uint32_t buflen = *(CTRLBUFFER_WORDPTR);	
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    FPGA_setlock(fpga_blockin);

    /* Do memory read */	
    udi_vendor_bulk_in_run(
            (uint8_t *) PSRAM_BASE_ADDRESS + address,
            buflen,
            main_vendor_bulk_in_received
            );	
}

void ctrl_readmem_ctrl(void){
    uint32_t buflen = *(CTRLBUFFER_WORDPTR);
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    FPGA_setlock(fpga_ctrlmem);

    /* Do memory read */
    ctrlmemread_buf = (uint8_t *) PSRAM_BASE_ADDRESS + address;

    /* Set size to read */
    ctrlmemread_size = buflen;

    /* Start Transaction */
}

void ctrl_writemem_ctrl_sam3u(void){
    uint32_t buflen = *(CTRLBUFFER_WORDPTR) - 4; // remove the first 4 bytes of the payload who contain the flags
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);
    uint32_t flags = *(CTRLBUFFER_WORDPTR + 2);

    uint8_t * ctrlbuf_payload = (uint8_t *)(CTRLBUFFER_WORDPTR + 3);
    uint8_t * sam3u_mem_b = (uint8_t *) sam3u_mem;

    /* Do memory write */
    for(unsigned int i = 0; i < buflen; i++){
        sam3u_mem_b[i+address] = ctrlbuf_payload[i];
    }

    if ( flags & 0x1 ){ // encryptions have been requested
        uint32_t seed = sam3u_mem[0]; // load the seed at addr 0

        for(unsigned int b = 0; b < (flags >> 16); b++){
            FPGA_setlock(fpga_generic);

            // set the inputs key if needed
            if ((flags >> 1) & 0x1){ // write the key
                for(unsigned int j = 0; j < 16; j++){
                    xram[j+0x400+0x100] = seed >> 24;
                    seed += (seed*seed) | 0x5;
                }
            }
            // set the inputs pt if needed
            if ((flags >> 2) & 0x1){ // write the pts
                for(unsigned int j = 0; j < 16; j++){
                    xram[j+0x400+0x200] = seed >> 24;
                    seed += (seed*seed) | 0x5;
                }
            }
            FPGA_setlock(fpga_unlocked);

            gpio_set_pin_high(FPGA_TRIGGER_GPIO);
            delay_cycles(50);
            gpio_set_pin_low(FPGA_TRIGGER_GPIO);
        }

    }

}

void ctrl_writemem_ctrl(void){
    uint32_t buflen = *(CTRLBUFFER_WORDPTR);
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    uint8_t * ctrlbuf_payload = (uint8_t *)(CTRLBUFFER_WORDPTR + 2);

    //printf("Writing to %x, %d\n", address, buflen);

    FPGA_setlock(fpga_generic);

    /* Start Transaction */

    /* Do memory write */
    for(unsigned int i = 0; i < buflen; i++){
        xram[i+address] = ctrlbuf_payload[i];
    }

    FPGA_setlock(fpga_unlocked);
}

void ctrl_writemem_bulk(void){
    //uint32_t buflen = *(CTRLBUFFER_WORDPTR);
    //uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    FPGA_setlock(fpga_blockout);

    /* Set address */
    //Not required - this is done automatically via the XMEM interface
    //instead of using a "cheater" port.

    /* Transaction done in generic callback */
}

static void ctrl_cdc_settings_cb(void)
{
    if (udd_g_ctrlreq.req.wValue & 0x01) {
        cdc_settings_change[0] = 1;
    } else {
        cdc_settings_change[0] = 0;
    }
    if (udd_g_ctrlreq.req.wValue & 0x02) {
        cdc_settings_change[1] = 1;
    } else {
        cdc_settings_change[1] = 0;
    }
}

static void ctrl_sam3ucfg_cb(void)
{
    switch(udd_g_ctrlreq.req.wValue & 0xFF)
    {
        /* Turn on slow clock */
        case 0x01:
            osc_enable(OSC_MAINCK_XTAL);
            osc_wait_ready(OSC_MAINCK_XTAL);
            pmc_switch_mck_to_mainck(CONFIG_SYSCLK_PRES);
            break;

            /* Turn off slow clock */
        case 0x02:
            pmc_switch_mck_to_pllack(CONFIG_SYSCLK_PRES);
            break;

            /* Jump to ROM-resident bootloader */
        case 0x03:
            /* Turn off connected stuff */
            //board_power(0);

            /* Clear ROM-mapping bit. */
            efc_perform_command(EFC0, EFC_FCMD_CGPB, 1);

            /* Disconnect USB (will kill connection) */
            udc_detach();

            /* With knowledge that I will rise again, I lay down my life. */
            while (RSTC->RSTC_SR & RSTC_SR_SRCMP);
            RSTC->RSTC_CR |= RSTC_CR_KEY(0xA5) | RSTC_CR_PERRST | RSTC_CR_PROCRST;
            while(1);
            break;

            /* Turn off FPGA Clock */
        case 0x04:
            gpio_configure_pin(PIN_PCK0, PIO_OUTPUT_0);
            break;

            /* Turn on FPGA Clock */
        case 0x05:
            gpio_configure_pin(PIN_PCK0, PIN_PCK0_FLAGS);
            break;

            /* Toggle trigger pin */
        case 0x06:
            break;
			
			/* Turn target power off */
		case 0x07:
			kill_fpga_power();
			break;
			
			/* Turn target power on */
		case 0x08:
			enable_fpga_power();
			break;
			

            /* Oh well, sucks to be you */
        default:
            break;
    }
}

static uint8_t cdce906_status;
static uint8_t cdce906_data;

#define USB_STATUS_NONE       0
#define USB_STATUS_PARAMWRONG 1
#define USB_STATUS_OK         2
#define USB_STATUS_COMMERR    3
#define USB_STATUS_CSFAIL     4

static void ctrl_cdce906_cb(void)
{
    //Catch heartbleed-style error
    if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size){
        return;
    }

    cdce906_status = USB_STATUS_NONE;

    if (udd_g_ctrlreq.req.wLength < 3){
        cdce906_status = USB_STATUS_PARAMWRONG;
        return;
    }

    cdce906_status = USB_STATUS_COMMERR;
    if (udd_g_ctrlreq.payload[0] == 0x00){
        if (cdce906_read(udd_g_ctrlreq.payload[1], &cdce906_data)){
            cdce906_status = USB_STATUS_OK;
        }

    } else if (udd_g_ctrlreq.payload[0] == 0x01){
        if (cdce906_write(udd_g_ctrlreq.payload[1], udd_g_ctrlreq.payload[2])){
            cdce906_status = USB_STATUS_OK;
        }
    } else {
        cdce906_status = USB_STATUS_PARAMWRONG;
        return;
    }
}

static uint8_t vccint_status = 0;
static uint16_t vccint_setting = 1000;

static void ctrl_vccint_cb(void)
{
    //Catch heartbleed-style error
    if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size){
        return;
    }

    vccint_status = USB_STATUS_NONE;

    if ((udd_g_ctrlreq.payload[0] ^ udd_g_ctrlreq.payload[1] ^ 0xAE) != (udd_g_ctrlreq.payload[2])){
        vccint_status = USB_STATUS_PARAMWRONG;
        return;
    }

    if (udd_g_ctrlreq.req.wLength < 3){
        vccint_status = USB_STATUS_CSFAIL;
        return;
    }

    uint16_t vcctemp = (udd_g_ctrlreq.payload[0]) | (udd_g_ctrlreq.payload[1] << 8);
    if ((vcctemp < 600) || (vcctemp > 1200)){
        vccint_status = USB_STATUS_PARAMWRONG;
        return;
    }

    vccint_status = USB_STATUS_COMMERR;

    if (tps56520_set(vcctemp)){
        vccint_setting = vcctemp;
        vccint_status = USB_STATUS_OK;
    }

    return;
}

static uint8_t fpgaspi_data_buffer[64];
static int fpga_spi_databuffer_len = 0;

static void ctrl_progfpgaspi(void){
	
	switch(udd_g_ctrlreq.req.wValue){
		case 0xA0:
			fpgaspi_program_init();			
			break;
			
		case 0xA1:
			fpgaspi_program_deinit();
			break;
			
		case 0xA2:
			fpgaspi_cs_low();
			break;

		case 0xA3:
			fpgaspi_cs_high();
			break;

		case 0xA4:
			//Catch heartbleed-style error
			if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size){
				return;
			}

			if (udd_g_ctrlreq.req.wLength > sizeof(fpgaspi_data_buffer)){
				return;
			}
			fpga_spi_databuffer_len = udd_g_ctrlreq.req.wLength;
			for (int i = 0; i < udd_g_ctrlreq.req.wLength; i++){
				fpgaspi_data_buffer[i] = fpgaspi_xferbyte(udd_g_ctrlreq.payload[i]);
			}
			break;

		default:
			break;
	}
}

/* Commands for GPIO config mode */
#define CONFIG_PIN_INPUT     0x01
#define CONFIG_PIN_OUTPUT    0x02
#define CONFIG_PIN_SPI1_MOSI 0x10
#define CONFIG_PIN_SPI1_MISO 0x11
#define CONFIG_PIN_SPI1_SCK  0x12
#define CONFIG_PIN_SPI1_CS   0x13

static void ctrl_fpgaioutil(void){
	
    if (udd_g_ctrlreq.req.wLength != 2){
        return;
    }

    int pin = udd_g_ctrlreq.payload[0];
    int config = udd_g_ctrlreq.payload[1];

	//SAM3X - largest index is 106
    if ((pin < 0) || (pin > 106)){
        return;
    }

	switch(udd_g_ctrlreq.req.wValue){
		case 0xA0: /* Configure IO Pin */
            switch(config)
            {
                case CONFIG_PIN_INPUT:
                    gpio_configure_pin(pin, PIO_INPUT);
                    break;
                case CONFIG_PIN_OUTPUT:
                    gpio_configure_pin(pin, PIO_OUTPUT_1);
                    break;
                case CONFIG_PIN_SPI1_MOSI:
                    if(pin_spi1_mosi > -1){
                        gpio_configure_pin(pin_spi1_mosi, PIO_DEFAULT);
                    }
                    gpio_configure_pin(pin, PIO_OUTPUT_0);
                    pin_spi1_mosi = pin;
                    break;
                case CONFIG_PIN_SPI1_MISO:
                    if(pin_spi1_miso > -1){
                        gpio_configure_pin(pin_spi1_miso, PIO_DEFAULT);
                    }
                    gpio_configure_pin(pin, PIO_INPUT);
                    pin_spi1_miso = pin;
                    break;
                case CONFIG_PIN_SPI1_SCK:
                    if(pin_spi1_sck > -1){
                        gpio_configure_pin(pin_spi1_sck, PIO_DEFAULT);
                    }
                    gpio_configure_pin(pin, PIO_OUTPUT_0);
                    pin_spi1_sck = pin;
                    break;
                case CONFIG_PIN_SPI1_CS:
                    if(pin_spi1_cs > -1){
                        gpio_configure_pin(pin_spi1_cs, PIO_DEFAULT);
                    }
                    gpio_configure_pin(pin, PIO_OUTPUT_1);
                    pin_spi1_cs = pin;                    
                    break;
                default:
                    //oops?
                    gpio_configure_pin(pin, PIO_DEFAULT);
                    break;
            }
			break;
			
		case 0xA1: /* Release IO Pin */
			//todo?
            gpio_configure_pin(pin, PIO_DEFAULT);
			break;

        case 0xA2: /* Set IO Pin state */
            if (config == 0){
                gpio_set_pin_low(pin);
            }

            if (config == 1){
                gpio_set_pin_high(pin);
            }
            break;

		default:
			break;
	}
}

static uint8_t spi1util_data_buffer[64];
static int spi1util_databuffer_len = 0;

static void ctrl_spi1util(void){
	
    
	switch(udd_g_ctrlreq.req.wValue){
		case 0xA0:
			spi1util_init();			
			break;
			
		case 0xA1:
			spi1util_deinit();
			break;
			
		case 0xA2:
			spi1util_cs_low();
			break;

		case 0xA3:
			spi1util_cs_high();
			break;

		case 0xA4:
			//Catch heartbleed-style error
			if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size){
				return;
			}

			if (udd_g_ctrlreq.req.wLength > sizeof(fpgaspi_data_buffer)){
				return;
			}
			spi1util_databuffer_len = udd_g_ctrlreq.req.wLength;
			for (int i = 0; i < udd_g_ctrlreq.req.wLength; i++){
				spi1util_data_buffer[i] = spi1util_xferbyte(udd_g_ctrlreq.payload[i]);
			}
			break;

		default:
			break;
	}
}

void ctrl_fpga_temp_cb(void)
{
	max1617_register_write(udd_g_ctrlreq.req.wValue & 0xFF, udd_g_ctrlreq.payload[0]);
}

bool main_setup_out_received(void)
{
    //Add buffer if used
    udd_g_ctrlreq.payload = ctrlbuffer;
    udd_g_ctrlreq.payload_size = min(udd_g_ctrlreq.req.wLength,	sizeof(ctrlbuffer));

    blockendpoint_usage = bep_emem;

    switch(udd_g_ctrlreq.req.bRequest){
        /* Memory Read */
        case REQ_MEMREAD_BULK:
            udd_g_ctrlreq.callback = ctrl_readmem_bulk;
            return true;
        case REQ_MEMREAD_CTRL:
            udd_g_ctrlreq.callback = ctrl_readmem_ctrl;
            return true;	

            /* Memory Write */
        case REQ_MEMWRITE_BULK:
            udd_g_ctrlreq.callback = ctrl_writemem_bulk;
            return true;

        case REQ_MEMWRITE_CTRL:
            udd_g_ctrlreq.callback = ctrl_writemem_ctrl;
            return true;		

        case REQ_MEMWRITE_CTRL_SAMU3:
            udd_g_ctrlreq.callback = ctrl_writemem_ctrl_sam3u;
            return true;		

            /* Send bitstream to FPGA */
        case REQ_FPGA_PROGRAM:
            udd_g_ctrlreq.callback = ctrl_progfpga_bulk;
            return true;

            /* XMEGA Programming */
        case REQ_XMEGA_PROGRAM:
            /*
               udd_g_ctrlreq.payload = xmegabuffer;
               udd_g_ctrlreq.payload_size = min(udd_g_ctrlreq.req.wLength,	sizeof(xmegabuffer));
            */
            udd_g_ctrlreq.callback = ctrl_xmega_program_void;
            return true;

            /* Misc hardware setup */
        case REQ_SAM3U_CFG:
            udd_g_ctrlreq.callback = ctrl_sam3ucfg_cb;
            return true;

        case REQ_CDC_SETTINGS_EN:
			udd_g_ctrlreq.callback = ctrl_cdc_settings_cb;
			return true;

            /* CDCE906 read/write */
        case REQ_CDCE906:
            udd_g_ctrlreq.callback = ctrl_cdce906_cb;
            return true;

            /* VCC-INT Setting */
        case REQ_VCCINT:
            udd_g_ctrlreq.callback = ctrl_vccint_cb;
            return true;

		/* Send SPI commands to FPGA-attached SPI flash */
		case REQ_FPGASPI_PROGRAM:
			udd_g_ctrlreq.callback = ctrl_progfpgaspi;
			return true;

        /* IO Util Setup */
        case REQ_FPGAIO_UTIL:
            udd_g_ctrlreq.callback = ctrl_fpgaioutil;
            return true;

        /* Bit-Banged SPI1 */
        case FREQ_FPGASPI1_XFER:
            udd_g_ctrlreq.callback = ctrl_spi1util;
            return true;
			
		case REQ_FPGA_TEMP:
			udd_g_ctrlreq.callback = ctrl_fpga_temp_cb;
			return true;
 
		case REQ_I2C_SETUP:
			udd_g_ctrlreq.callback = ctrl_i2c_setup;
			return true;
		case REQ_I2C_DATA:
			udd_g_ctrlreq.callback = ctrl_i2c_send;
			return true;
        default:
            return false;
    }					
}


void ctrl_progfpga_bulk(void){

    switch(udd_g_ctrlreq.req.wValue){
        case 0xA0:
            fpga_program_setup1();			
            break;

        case 0xA1:
            /* Waiting on data... */
            fpga_program_setup2();
            blockendpoint_usage = bep_fpgabitstream;
            break;

        case 0xA2:
            /* Done */
            blockendpoint_usage = bep_emem;
            break;

        default:
            break;
    }
}


bool main_setup_in_received(void)
{
    /*
       udd_g_ctrlreq.payload = main_buf_loopback;
       udd_g_ctrlreq.payload_size =
       min( udd_g_ctrlreq.req.wLength,
       sizeof(main_buf_loopback) );
       */

    static uint8_t  respbuf[64];
    //unsigned int cnt;
	
	int pin;
	uint8_t addr;

    switch(udd_g_ctrlreq.req.bRequest){
        case REQ_MEMREAD_CTRL:
            udd_g_ctrlreq.payload = ctrlmemread_buf;
            udd_g_ctrlreq.payload_size = ctrlmemread_size;
            ctrlmemread_size = 0;

            if (FPGA_lockstatus() == fpga_ctrlmem){
                FPGA_setlock(fpga_unlocked);
            }

            return true;
            break;

        case REQ_FPGA_STATUS:
            respbuf[0] = FPGA_ISDONE();
            respbuf[1] = FPGA_INITB_STATUS();
            respbuf[2] = 0;
            respbuf[3] = 0;
            udd_g_ctrlreq.payload = respbuf;
            udd_g_ctrlreq.payload_size = 4;
            return true;
            break;

        case REQ_XMEGA_PROGRAM:
            break;

        case REQ_CDC_SETTINGS_EN:
            respbuf[0] = cdc_settings_change[0];
            respbuf[1] = cdc_settings_change[1];
            udd_g_ctrlreq.payload = respbuf;
            udd_g_ctrlreq.payload_size = 2;
            return true;
            break;

        case REQ_FW_VERSION:
            respbuf[0] = FW_VER_MAJOR;
            respbuf[1] = FW_VER_MINOR;
            respbuf[2] = FW_VER_DEBUG;
            udd_g_ctrlreq.payload = respbuf;
            udd_g_ctrlreq.payload_size = 3;
            return true;
            break;

        case REQ_CDCE906:
            respbuf[0] = cdce906_status;
            respbuf[1] = cdce906_data;
            udd_g_ctrlreq.payload = respbuf;
            udd_g_ctrlreq.payload_size = 2;
            return true;
            break;

        case REQ_VCCINT:
            respbuf[0] = vccint_status;
            respbuf[1] = (uint8_t)vccint_setting;
            respbuf[2] = (uint8_t)(vccint_setting >> 8);
            udd_g_ctrlreq.payload = respbuf;
            udd_g_ctrlreq.payload_size = 3;
            return true;
            break;	

		case REQ_FPGASPI_PROGRAM:						
			if (udd_g_ctrlreq.req.wLength > sizeof(fpgaspi_data_buffer))
            {
                return false;
            }
			udd_g_ctrlreq.payload = fpgaspi_data_buffer;
			udd_g_ctrlreq.payload_size = udd_g_ctrlreq.req.wLength;
			return true;
			break;

        case FREQ_FPGASPI1_XFER:
 			if (udd_g_ctrlreq.req.wLength > sizeof(spi1util_data_buffer))
            {
                return false;
            }
			udd_g_ctrlreq.payload = spi1util_data_buffer;
			udd_g_ctrlreq.payload_size = udd_g_ctrlreq.req.wLength;
			return true;
			break;
			
		case REQ_FPGAIO_UTIL:			
			pin = udd_g_ctrlreq.req.wValue & 0xFF;
			respbuf[0] = gpio_pin_is_high(pin);
			udd_g_ctrlreq.payload = respbuf;
			udd_g_ctrlreq.payload_size = 1;
			return true;
			break;         
		case REQ_FPGA_TEMP:
			addr = udd_g_ctrlreq.req.wValue & 0xFF;
			max1617_register_read(addr, respbuf);
			udd_g_ctrlreq.payload = respbuf;
			udd_g_ctrlreq.payload_size = 1;
			return true;
			break;

        case REQ_I2C_SETUP:
			respbuf[0] = USER_TWI_PACKET.chip;
			for (uint8_t i = 0; i < USER_TWI_PACKET.addr_length; i++) {
				respbuf[i + 1] = USER_TWI_PACKET.addr[i];
			}
			udd_g_ctrlreq.payload = respbuf;
			udd_g_ctrlreq.payload_size = USER_TWI_PACKET.addr_length + 1;
			return true;
			break;
			
		case REQ_I2C_DATA:
			USER_TWI_PACKET.length = udd_g_ctrlreq.req.wLength;			     
			USER_TWI_PACKET.buffer = respbuf;
			twi_master_read(TWI0, &USER_TWI_PACKET);
			udd_g_ctrlreq.payload = respbuf;
			udd_g_ctrlreq.payload_size = USER_TWI_PACKET.length;
			return true;
			break;

        default:
            return false;
    }
    return false;
}





void main_vendor_bulk_in_received(udd_ep_status_t status,
        iram_size_t nb_transfered, udd_ep_id_t ep)
{
    UNUSED(nb_transfered);
    UNUSED(ep);
    if (UDD_EP_TRANSFER_OK != status) {
        return; // Transfer aborted/error
    }	

    if (FPGA_lockstatus() == fpga_blockin){		
        FPGA_setlock(fpga_unlocked);
    }
}

void main_vendor_bulk_out_received(udd_ep_status_t status,
        iram_size_t nb_transfered, udd_ep_id_t ep)
{
    UNUSED(ep);
    if (UDD_EP_TRANSFER_OK != status) {
        // Transfer aborted

        //restart
        udi_vendor_bulk_out_run(
                main_buf_loopback,
                sizeof(main_buf_loopback),
                main_vendor_bulk_out_received);

        return;
    }

    if (blockendpoint_usage == bep_emem){
        for(unsigned int i = 0; i < nb_transfered; i++){
            xram[i] = main_buf_loopback[i];
        }

        if (FPGA_lockstatus() == fpga_blockout){
            FPGA_setlock(fpga_unlocked);
        }
    } else if (blockendpoint_usage == bep_fpgabitstream){

        /* Send byte to FPGA - this could eventually be done via SPI */		
        for(unsigned int i = 0; i < nb_transfered; i++){
            fpga_program_sendbyte(main_buf_loopback[i]);
        }

        FPGA_CCLK_LOW();
    }

    //printf("BULKOUT: %d bytes\n", (int)nb_transfered);

    udi_vendor_bulk_out_run(
            main_buf_loopback,
            sizeof(main_buf_loopback),
            main_vendor_bulk_out_received);
}


/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
// USB CDC
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////
#include "usb_protocol_cdc.h"
volatile bool enable_cdc_transfer[2] = {false, false};
	extern volatile bool usart_x_enabled[4];
bool cdc_enable(uint8_t port)
{
	enable_cdc_transfer[port] = true;
	return true;
}

void cdc_disable(uint8_t port)
{
	enable_cdc_transfer[port] = false;
}

/*
		case REQ_USART0_DATA:
		for(cnt = 0; cnt < udd_g_ctrlreq.req.wLength; cnt++){
			respbuf[cnt] = usart_driver_getchar(USART_TARGET);
		}
		udd_g_ctrlreq.payload = respbuf;
		udd_g_ctrlreq.payload_size = cnt;
		return true;
		break;
		
			//Catch heartbleed-style error
			if (udd_g_ctrlreq.req.wLength > udd_g_ctrlreq.payload_size){
				return;
			}
			
			for (int i = 0; i < udd_g_ctrlreq.req.wLength; i++){
				usart_driver_putchar(USART_TARGET, NULL, udd_g_ctrlreq.payload[i]);
			}
*/
static uint8_t uart_buf[512] = {0};
void my_callback_rx_notify(uint8_t port)
{
	//iram_size_t udi_cdc_multi_get_nb_received_data
	
	if (enable_cdc_transfer[port] && usart_x_enabled[0]) {
		iram_size_t num_char = udi_cdc_multi_get_nb_received_data(port);
		while (num_char > 0) {
			num_char = (num_char > 512) ? 512 : num_char;
			udi_cdc_multi_read_buf(port, uart_buf, num_char);
			for (uint16_t i = 0; i < num_char; i++) { //num_char; num_char > 0; num_char--) {
				//usart_driver_putchar(USART_TARGET, NULL, udi_cdc_multi_getc(port));
				if (port == 0) {
					usart_driver_putchar(USART0, NULL, uart_buf[i]);
				} else if (port == 1) {
					usart_driver_putchar(USART1, NULL, uart_buf[i]);
				}
				
			}
			num_char = udi_cdc_multi_get_nb_received_data(port);
		}
	}
}

extern tcirc_buf rx0buf, tx0buf;
extern tcirc_buf usb_usart_circ_buf0;

extern tcirc_buf rx1buf, tx1buf;
extern tcirc_buf usb_usart_circ_buf1;

void my_callback_config(uint8_t port, usb_cdc_line_coding_t * cfg)
{
	if (enable_cdc_transfer[port]) {
		sam_usart_opt_t usartopts;
		if (cfg->bDataBits < 5)
			return;
		if (cfg->bCharFormat > 2)
			return;
	
		usartopts.baudrate = cfg->dwDTERate;
		usartopts.channel_mode = US_MR_CHMODE_NORMAL;
		usartopts.stop_bits = ((uint32_t)cfg->bCharFormat) << 12;
		usartopts.char_length = ((uint32_t)cfg->bDataBits - 5) << 6;
		switch(cfg->bParityType) {
			case CDC_PAR_NONE:
			usartopts.parity_type = US_MR_PAR_NO;
			break;
			case CDC_PAR_ODD:
			usartopts.parity_type = US_MR_PAR_ODD;
			break;
			case CDC_PAR_EVEN:
			usartopts.parity_type = US_MR_PAR_EVEN;
			break;
			case CDC_PAR_MARK:
			usartopts.parity_type = US_MR_PAR_MARK;
			break;
			case CDC_PAR_SPACE:
			usartopts.parity_type = US_MR_PAR_SPACE;
			break;
			default:
			return;
		}
		if (port == 0)
		{
			//completely restart USART - otherwise breaks tx or stalls
			sysclk_enable_peripheral_clock(ID_USART0);
			init_circ_buf(&usb_usart_circ_buf0);
			init_circ_buf(&tx0buf);
			init_circ_buf(&rx0buf);
			usart_init_rs232(USART0, &usartopts,  sysclk_get_cpu_hz());
			
			usart_enable_rx(USART0);
			usart_enable_tx(USART0);
			
			usart_enable_interrupt(USART0, UART_IER_RXRDY);
			
			//Done elsewhere
			//gpio_configure_pin(PIN_USART0_RXD, PIN_USART0_RXD_FLAGS);
			//gpio_configure_pin(PIN_USART0_TXD, PIN_USART0_TXD_FLAGS);
			irq_register_handler(USART0_IRQn, 5);
			usart_x_enabled[0] = true;
		} else if (port == 1) {
			//completely restart USART - otherwise breaks tx or stalls
			sysclk_enable_peripheral_clock(ID_USART1);
			init_circ_buf(&usb_usart_circ_buf1);
			init_circ_buf(&tx1buf);
			init_circ_buf(&rx1buf);
			usart_init_rs232(USART1, &usartopts,  sysclk_get_cpu_hz());
						
			usart_enable_rx(USART1);
			usart_enable_tx(USART1);
						
			usart_enable_interrupt(USART1, UART_IER_RXRDY);
			
			//Done elsewhere	
			//gpio_configure_pin(PIN_USART1_RXD, PIN_USART1_RXD_FLAGS);
			//gpio_configure_pin(PIN_USART1_TXD, PIN_USART1_TXD_FLAGS);
			irq_register_handler(USART1_IRQn, 5);
			usart_x_enabled[1] = true;
		}
	}
		
}