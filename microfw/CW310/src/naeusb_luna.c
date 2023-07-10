#include "naeusb.h"
#include "naeusb_luna.h"
#include "naeusb_default.h"
#include "fpga_program.h"
#include "naeusb_fpga_target.h"
#include "fpga_selectmap.h"
#include "usb_xmem.h"
#include "pdc.h"
#if FPGA_ALE_GPIO == PIO_PC17_IDX
#error ALE wrong pin
#endif

#if FPGA_TRIGGER_GPIO == PIO_PC13_IDX
#error ALE wrong pin
#endif

uint8_t FPGA_TRANSFER_16BIT = 0;
uint32_t FPGA_COMM_SPEED = 0;

uint32_t FPGA_MODE_PINS[] = {PIN_FPGA_M0, PIN_FPGA_M1, PIN_FPGA_M2};
uint8_t FPGA_CURRENT_PROG_MODE = 0;
extern blockep_usage_t blockendpoint_usage;

static uint8_t * ctrlmemread_buf;
static unsigned int ctrlmemread_size;

void main_vendor_bulk_out_received(udd_ep_status_t status,
                                   iram_size_t nb_transfered, udd_ep_id_t ep);
void luna_vendor_bulk_out_received(udd_ep_status_t status,
                                  iram_size_t nb_transfered, udd_ep_id_t ep);
void luna_vendor_bulk_in_received(udd_ep_status_t status,
                                  iram_size_t nb_transfered, udd_ep_id_t ep);
void setup_fpga_rw(void);
void fpga_pins(bool enabled);

/*
Buffer to hold data to send to FPGA/read from FPGA.

Need to write on upper FPGA bytes, so can't directly
setup bulk read/write to act on the SMC memory addr
*/
static volatile uint32_t FPGA_WR_LEFT; //number of bytes left in transfer
static volatile uint8_t FPGA_WR_BUF[256]; //buffer for holding data for FPGA transfer

enum FPGA_PROG_MODE {
    FPGA_PROG_MODE_SERIAL,
    FPGA_PROG_MODE_PARALLEL,
    FPGA_PROG_MODE_PARALLEL16
};

void luna_fpga_settings(void)
{
    setup_fpga_rw();
}

void setup_fpga_rw(void)
{
    fpga_pins(1);
	pmc_enable_periph_clk(ID_SMC);
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

    // TODO: no longer needed, just do 16 bit version
    smc_set_mode(SMC, 0, SMC_MODE_DBW_BIT_16 | SMC_MODE_WRITE_MODE_NCS_CTRL | SMC_MODE_READ_MODE_NCS_CTRL);
}

void luna_readmem_bulk(void)
{
    uint32_t buflen = *(CTRLBUFFER_WORDPTR);
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    FPGA_WR_LEFT = buflen;

    uint16_t bytes_to_transfer = min(FPGA_WR_LEFT, sizeof(FPGA_WR_BUF)); // get number of bytes to read in this transfer

    FPGA_releaselock();
    while(!FPGA_setlock(fpga_blockin));
    FPGA_setaddr(address);

    udd_ep_abort(UDI_VENDOR_EP_BULK_IN); //make sure no ongoing transfer

    luna_fpga_settings();

    // Do the read now so that we have data when the PC is ready
    for (uint16_t i = 0; i < bytes_to_transfer; i++) {
        FPGA_WR_BUF[i] = (xram16[i] >> 8) & 0xFF; //read from upper byte as bottom 4 bits not usable by FPGA
    }

    // do the transfer
    if  (!udi_vendor_bulk_in_run(
        FPGA_WR_BUF,
        bytes_to_transfer,
        luna_vendor_bulk_in_received
        )) {
            //abort, TODO: again should do error handling?
        }
}

void luna_readmem_ctrl(void)
{
    //TODO: check buflen valid
    uint32_t buflen = *(CTRLBUFFER_WORDPTR);
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    FPGA_releaselock();

    while(!FPGA_setlock(fpga_ctrlmem));


    FPGA_setaddr(address);

    luna_fpga_settings();

    // do read
    for (uint32_t i = 0; i < buflen; i++) {
        respbuf[i] = xram16[i] >> 8;
    }
    ctrlmemread_buf = respbuf;
    ctrlmemread_size = buflen;
    FPGA_releaselock();
}

void luna_writemem_bulk(void)
{
    uint32_t buflen = *(CTRLBUFFER_WORDPTR);
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    FPGA_WR_LEFT = buflen;

    FPGA_releaselock();

    while(!FPGA_setlock(fpga_blockout));


    udd_ep_abort(UDI_VENDOR_EP_BULK_OUT); //make sure no ongoing transfer

    FPGA_setaddr(address);

    luna_fpga_settings();
    if  (!udi_vendor_bulk_out_run(
        FPGA_WR_BUF,
        sizeof(FPGA_WR_BUF),
        luna_vendor_bulk_out_received
        )) {
            //abort //TODO: should do some sort of error handling?
        }
}

void luna_writemem_ctrl(void)
{
    uint32_t buflen = *(CTRLBUFFER_WORDPTR);
    uint32_t address = *(CTRLBUFFER_WORDPTR + 1);

    FPGA_releaselock();
    while(!FPGA_setlock(fpga_generic));

    FPGA_setaddr(address);

    luna_fpga_settings();
    uint8_t *ctrlbuf_payload = (uint8_t *)(CTRLBUFFER_WORDPTR + 2);
    FPGA_setlock(fpga_generic);

    for (uint32_t i = 0; i < buflen; i++) {
        xram16[i] = ((uint16_t)ctrlbuf_payload[i]) << 8; //write to upper byte as bottom 4 bits not usable by FPGA
        // xram16[i] = ((uint16_t)FPGA_WR_BUF[i]); //write to upper byte as bottom 4 bits not usable by FPGA
    }
    FPGA_releaselock();
}

void luna_vendor_bulk_in_received(udd_ep_status_t status,
                                  iram_size_t nb_transfered, udd_ep_id_t ep)
{
    UNUSED(ep);
    if (UDD_EP_TRANSFER_OK != status) {
        // Transfer aborted
        FPGA_releaselock();
        return;
    }

    if (nb_transfered < FPGA_WR_LEFT) {
        // subtract what we transferred
        FPGA_WR_LEFT -= nb_transfered;
    } else {
        // otherwise, we're done with the read
        FPGA_WR_LEFT = 0;
        FPGA_releaselock();
        return;
    }
    uint16_t bytes_to_transfer = min(FPGA_WR_LEFT, sizeof(FPGA_WR_BUF));

    // read in the bytes we want to send to the PC
    for (uint16_t i = 0; i < bytes_to_transfer; i++) {
        FPGA_WR_BUF[i] = (xram16[i] >> 8) & 0xFF; //read from upper byte as bottom 4 bits not usable by FPGA
    }

    // setup transfer for sending bytes to PC
    if  (!udi_vendor_bulk_in_run(
        FPGA_WR_BUF,
        bytes_to_transfer,
        luna_vendor_bulk_in_received
        )) {
            //abort, TODO: again should do error handling?
        }
}

void luna_vendor_bulk_out_received(udd_ep_status_t status,
                                  iram_size_t nb_transfered, udd_ep_id_t ep)
{
    UNUSED(ep);
    FPGA_releaselock();
    if (UDD_EP_TRANSFER_OK != status) {
        // Transfer aborted
        FPGA_releaselock();
        return;
    }

    // transfer the bytes we got from the PC
    for (uint16_t i = 0; i < nb_transfered; i++) {
        xram16[i] = ((uint16_t)FPGA_WR_BUF[i]) << 8; //write to upper byte as bottom 4 bits not usable by FPGA
    }

    // if we haven't transferred all data, setup bulk out run again
    if (nb_transfered < FPGA_WR_LEFT) {
        FPGA_WR_LEFT -= nb_transfered;
        if  (!udi_vendor_bulk_out_run(
            FPGA_WR_BUF,
            sizeof(FPGA_WR_BUF),
            luna_vendor_bulk_out_received
            )) {
                //abort, TODO: again should do error handling?
            }
    } else {
        FPGA_releaselock();
    }

}

void luna_progfpga_bulk(void) 
{
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
    case REQ_MEMREAD_BULK:
        // memory read
        if (FPGA_setlock(fpga_usblocked)){
            udd_g_ctrlreq.callback = luna_readmem_bulk;
            return true;
        }
        break;
    case REQ_MEMREAD_CTRL:
        if (FPGA_setlock(fpga_usblocked)){
            udd_g_ctrlreq.callback = luna_readmem_ctrl;
            return true;
        }
        break;

        /* Memory Write */
    case REQ_MEMWRITE_BULK:
        if (FPGA_setlock(fpga_usblocked)){
            udd_g_ctrlreq.callback = luna_writemem_bulk;
            return true;
        }
        break;
    case REQ_MEMWRITE_CTRL:
        if (FPGA_setlock(fpga_usblocked)){
            udd_g_ctrlreq.callback = luna_writemem_ctrl;
            return true;
        }
        break;
        case REQ_FPGA_PROGRAM:
            udd_g_ctrlreq.callback = luna_progfpga_bulk;
            return true;
    case REQ_LUNA_FPGA_SETTINGS:
        udd_g_ctrlreq.callback = luna_fpga_settings;
        return true;
        break;

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

        case REQ_MEMREAD_CTRL:
            udd_g_ctrlreq.payload = ctrlmemread_buf;
            udd_g_ctrlreq.payload_size = ctrlmemread_size;
            ctrlmemread_size = 0;

            FPGA_releaselock();
            return true;
            break;

        case REQ_LUNA_FPGA_SETTINGS:
            respbuf[0] = FPGA_TRANSFER_16BIT;
            // TODO: FPGA programming speed here
            respbuf[1] = 0;
            respbuf[2] = 0;
            respbuf[3] = 0;
            respbuf[4] = 0;
            udd_g_ctrlreq.payload = respbuf;
            udd_g_ctrlreq.payload_size = 5;
    }
    return false;
}

void luna_register_handlers(void)
{
    naeusb_add_in_handler(luna_setup_in_received);
    naeusb_add_out_handler(luna_setup_out_received);
}