#include "naeusb.h"
#include "naeusb_luna.h"
#include "naeusb_default.h"
#include "fpga_program.h"
#include "fpga_selectmap.h"

uint32_t FPGA_MODE_PINS[] = {PIN_FPGA_M0, PIN_FPGA_M1, PIN_FPGA_M2};

uint8_t FPGA_CURRENT_PROG_MODE = 0;

enum FPGA_PROG_MODE {
    FPGA_PROG_MODE_DETECT,
    FPGA_PROG_MODE_SERIAL,
    FPGA_PROG_MODE_PARALLEL,
    FPGA_PROG_MODE_UNKNOWN
};

void set_mode_pins(void)
{
    FPGA_MODE_PIN_STATE = udd_g_ctrlreq.payload[0] & 0b111;
    for (uint8_t i = 0; i < 3; i++) {
        if (FPGA_MODE_PIN_STATE & (1 << i)) {
            gpio_set_pin_high(FPGA_MODE_PINS[i]);
        } else {
            gpio_set_pin_low(FPGA_MODE_PINS[i]);
        }
    }
}

uint8_t detect_programming_mode(void)
{
    uint8_t pin_vals = 0;
    gpio_pin_is_high(PIN_FPGA_M0);
    for (uint8_t i = 0; i < 3; i++) {
        pin_vals |= gpio_pin_is_high(FPGA_MODE_PINS[i]) << i;
    }

    if (pin_vals == 0b111) {
        return FPGA_PROG_MODE_SERIAL;
    } else if (pin_vals == 0b110) {
        return FPGA_PROG_MODE_PARALLEL;
    }
    return FPGA_PROG_MODE_UNKNOWN;

}

void luna_progfpga_bulk(void) {
    uint32_t prog_freq = 20E6;
    // uint8_t prog_mode = (udd_g_ctrlreq.wValue >> 8) & 0xFF;
    switch (udd_g_ctrlreq.wValue & 0xFF) {
        case 0xA0:
            FPGA_CURRENT_PROG_MODE = (udd_g_ctrlreq.wValue >> 8) & 0xFF;
            if (FPGA_CURRENT_PROG_MODE == FPGA_PROG_MODE_DETECT) {
                FPGA_CURRENT_PROG_MODE = detect_programming_mode();
            }
            if (udd_g_ctrlreq.req.wLength == 4) {
                prog_freq = *(CTRLBUFFER_WORDPTR);
            }

            if (FPGA_CURRENT_PROG_MODE == FPGA_PROG_MODE_SERIAL)
                fpga_program_setup1(prog_freq);	
            else if (FPGA_CURRENT_PROG_MODE == FPGA_PROG_MODE_PARALLEL)

            break;
    }
}

bool luna_setup_out_received(void)
{
	switch (udd_g_ctrlreq.req.bRequest) {
        case REQ_FPGA_PROGRAM:
            udd_g_ctrlreq.callback = set_mode_pins;
            return true;
    }
    return false;
}

bool luna_setup_in_received(void)
{

	switch (udd_g_ctrlreq.req.bRequest) {
        case REQ_FPGA_MODE_PINS:
            respbuf[0] = FPGA_MODE_PIN_STATE;
            udd_g_ctrlreq.payload = respbuf;
            udd_g_ctrlreq.payload_size = 1;
            return true;
    }
    return false;
}

void luna_register_handlers(void)
{
    naeusb_add_in_handler(luna_setup_in_received);
    naeusb_add_out_handler(luna_setup_out_received);
}