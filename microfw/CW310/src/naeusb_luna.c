#include "naeusb.h"
#include "naeusb_luna.h"
#include "naeusb_default.h"

uint8_t FPGA_MODE_PIN_STATE = 0b111;
uint32_t FPGA_MODE_PINS[] = {PIN_FPGA_M0, PIN_FPGA_M1, PIN_FPGA_M2};

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

bool luna_setup_out_received(void)
{
	switch (udd_g_ctrlreq.req.bRequest) {
        case REQ_FPGA_MODE_PINS:
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