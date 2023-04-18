#include "naeusb.h"
#include "naeusb_luna.h"
#include "naeusb_default.h"
#include "fpga_program.h"
#include "naeusb_fpga_target.h"
#include "fpga_selectmap.h"
#include "usb_xmem.h"
#include "pdc.h"



uint32_t FPGA_MODE_PINS[] = {PIN_FPGA_M0, PIN_FPGA_M1, PIN_FPGA_M2};
uint8_t FPGA_CURRENT_PROG_MODE = 0;
extern blockep_usage_t blockendpoint_usage;

void main_vendor_bulk_out_received(udd_ep_status_t status,
                                   iram_size_t nb_transfered, udd_ep_id_t ep);

enum FPGA_PROG_MODE {
    FPGA_PROG_MODE_SERIAL,
    FPGA_PROG_MODE_PARALLEL,
    FPGA_PROG_MODE_PARALLEL16
};

void luna_progfpga_bulk(void) {
    uint32_t prog_freq = 20E6;
    // uint8_t prog_mode = (udd_g_ctrlreq.wValue >> 8) & 0xFF;
    switch (udd_g_ctrlreq.req.wValue & 0xFF) {
        case 0xA0:
            FPGA_CURRENT_PROG_MODE = (udd_g_ctrlreq.req.wValue >> 8) & 0x7F;
            uint8_t parallel16 = 1;
            if (udd_g_ctrlreq.req.wLength == 4) {
                prog_freq = *(CTRLBUFFER_WORDPTR);
            }
            switch (FPGA_CURRENT_PROG_MODE) {
            case FPGA_PROG_MODE_SERIAL:
                gpio_configure_pin(PIN_FPGA_M0, PIO_OUTPUT_1);
                gpio_configure_pin(PIN_FPGA_M1, PIO_OUTPUT_1);
                gpio_configure_pin(PIN_FPGA_M2, PIO_OUTPUT_1);
                gpio_configure_pin(PIN_EBI_DATA_BUS_D1, PIO_INPUT);
                gpio_configure_pin(PIN_EBI_NWE, PIO_INPUT);
                fpga_program_setup1(prog_freq);	

                // #ifdef SERIAL_PROG_DMA
                //     DMA_init();
                // #endif
                break;
            case FPGA_PROG_MODE_PARALLEL:
                parallel16 = 0;
            case FPGA_PROG_MODE_PARALLEL16:
                gpio_configure_pin(PIN_FPGA_M0, PIO_OUTPUT_0);
                gpio_configure_pin(PIN_FPGA_M1, PIO_OUTPUT_1);
                gpio_configure_pin(PIN_FPGA_M2, PIO_OUTPUT_1);
                fpga_selectmap_setup1(parallel16, prog_freq); //NOTE: prog freq is setup time, so small=fast
                break;
            }

            break;
        case 0xA1:
            switch (FPGA_CURRENT_PROG_MODE) {
                case FPGA_PROG_MODE_SERIAL:
                    fpga_program_setup2();	
                    break;
                case FPGA_PROG_MODE_PARALLEL:
                case FPGA_PROG_MODE_PARALLEL16:
                    fpga_selectmap_setup2();
                    udd_ep_abort(UDI_VENDOR_EP_BULK_OUT);
                    if (!udi_vendor_bulk_out_run(xram, 0xFFFFFFFF, NULL)) {
                        // could technically return non-zero if endpoint is in use
                    }
                    break;
            }
            break;
        case 0xA2:
            if (FPGA_CURRENT_PROG_MODE == FPGA_PROG_MODE_SERIAL) {
                fpga_program_finish();
            } else if (FPGA_CURRENT_PROG_MODE == FPGA_PROG_MODE_PARALLEL) {
                udd_ep_abort(UDI_VENDOR_EP_BULK_OUT);
                fpga_selectmap_setup3();
            }
            break;


    }
}

bool luna_setup_out_received(void)
{
	switch (udd_g_ctrlreq.req.bRequest) {
        case REQ_FPGA_PROGRAM:
            udd_g_ctrlreq.callback = luna_progfpga_bulk;
            return true;
    }
    return false;
}

bool luna_setup_in_received(void)
{

	switch (udd_g_ctrlreq.req.bRequest) {
        case REQ_FPGA_MODE_PINS:
            respbuf[0] = FPGA_CURRENT_PROG_MODE;
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