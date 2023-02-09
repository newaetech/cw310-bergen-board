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

#define BOARD_USART_DMAC_TX_CH 0
#define USART_TX_IDX 11 // this is apparently not documented anywhere 
#define PROG_DMA_BUF_SIZE 1024

#define SERIAL_PROG_DMA

enum dma_prog_buf_state {
    DMA_PROG_BUF_EMPTY,
    DMA_PROG_BUF_FULL,
    DMA_PROG_BUF_EMPTYING,
    DMA_PROG_BUF_FILLING
};

struct dma_prog_buf {
    COMPILER_WORD_ALIGNED volatile uint8_t buf[PROG_DMA_BUF_SIZE];
    uint16_t buflen;
    enum dma_prog_buf_state state;
};

static struct dma_prog_buf dma_prog_buffers[2]; //should be zero'd

volatile uint8_t usb_current_buffer = 0;
volatile uint8_t usart_current_buffer = 1;

void main_vendor_bulk_out_received(udd_ep_status_t status,
                                   iram_size_t nb_transfered, udd_ep_id_t ep);

void fpga_prog_bulk_out_received(udd_ep_status_t status,
                                   iram_size_t nb_transfered, udd_ep_id_t ep);

void DMA_init(void)
{
    NVIC_EnableIRQ(USART2_IRQn);
    // usart_enable_interrupt(USART2, UART_IER_TXBUFE); // this fires if the buffer is ever empty

    dma_prog_buffers[0].buflen = 0;
    dma_prog_buffers[0].state = DMA_PROG_BUF_EMPTY;
    dma_prog_buffers[1].buflen = 0;
    dma_prog_buffers[1].state = DMA_PROG_BUF_EMPTY;

    usb_current_buffer = 0;
    usart_current_buffer = 1;

    // start reading data in
    udi_vendor_bulk_out_run(dma_prog_buffers[usb_current_buffer].buf, 
        PROG_DMA_BUF_SIZE, fpga_prog_bulk_out_received);
}

// we're done now, shut er down
void DMA_shutdown(void)
{
    NVIC_DisableIRQ(USART2_IRQn);
    usart_disable_interrupt(USART2, US_IDR_TXBUFE);
    Pdc *usart_pdc = usart_get_pdc_base(USART2);
    pdc_disable_transfer(usart_pdc, PERIPH_PTCR_TXTDIS);
}

void setup_usart_DMA(uint8_t *buf, uint16_t buflen)
{
    Pdc *usart_pdc = usart_get_pdc_base(USART2);
    pdc_packet_t usart_packet;

    usart_packet.ul_addr = (uint32_t)buf;
    usart_packet.ul_size = buflen;

    pdc_tx_init(usart_pdc, &usart_packet, NULL);
    pdc_enable_transfer(usart_pdc, PERIPH_PTCR_TXTEN);
    usart_enable_interrupt(USART2, US_IER_TXBUFE);
}

ISR(USART2_Handler)
{
    uint32_t usart_status;
    usart_status = usart_get_status(USART2);
    Pdc *usart_pdc = usart_get_pdc_base(USART2);
    if (usart_status & (US_CSR_TXBUFE)) {
        usart_disable_interrupt(USART2, US_IDR_TXBUFE);
        pdc_disable_transfer(usart_pdc, PERIPH_PTCR_TXTDIS);
        dma_prog_buffers[usart_current_buffer].state = DMA_PROG_BUF_EMPTY;
        dma_prog_buffers[usart_current_buffer].buflen = 0; //empty buffer
        if (dma_prog_buffers[usb_current_buffer].state == DMA_PROG_BUF_FULL) {

            // other buffer is full, so send the bitstream out
            setup_usart_DMA(dma_prog_buffers[usb_current_buffer].buf, 
                dma_prog_buffers[usb_current_buffer].buflen);
            dma_prog_buffers[usb_current_buffer].state = DMA_PROG_BUF_EMPTYING;

            // this buffer is empty, so load some USB data into it
            udi_vendor_bulk_out_run(dma_prog_buffers[usart_current_buffer].buf, 
                PROG_DMA_BUF_SIZE, fpga_prog_bulk_out_received);
            dma_prog_buffers[usart_current_buffer].state = DMA_PROG_BUF_FILLING;

            // other buffer is now being sent out over usart, this one is being filled by USB data
            uint8_t tmp = usart_current_buffer;
            usart_current_buffer = usb_current_buffer;
            usb_current_buffer = tmp;
        } else if (dma_prog_buffers[usb_current_buffer].state == DMA_PROG_BUF_EMPTY) {
            // this shouldn't happen, but if both buffers are empty, fill this one
            udi_vendor_bulk_out_run(dma_prog_buffers[usart_current_buffer].buf, 
                PROG_DMA_BUF_SIZE, fpga_prog_bulk_out_received);
            dma_prog_buffers[usart_current_buffer].state = DMA_PROG_BUF_FILLING;

            // other buffer is still empty, this one is being filled by USB data
            // we still swap in this case
            uint8_t tmp = usart_current_buffer;
            usart_current_buffer = usb_current_buffer;
            usb_current_buffer = tmp;
        } else {
            // I think this has to be when the other buffer is filling
            // in any case, we don't have anything to do
            return;
        }
    }
}


// similar logic to above, but everything's swapped
void fpga_prog_bulk_out_received(udd_ep_status_t status,
                                   iram_size_t nb_transfered, udd_ep_id_t ep)
{
    
    if (UDD_EP_TRANSFER_OK != status) {
        // likely the whole transmission was aborted, or we're finished
        return;
    }

    dma_prog_buffers[usb_current_buffer].state = DMA_PROG_BUF_FULL;
    dma_prog_buffers[usb_current_buffer].buflen = nb_transfered; //should be the max buffer length until the last transaction

    if (dma_prog_buffers[usart_current_buffer].state == DMA_PROG_BUF_EMPTY) {

        // other buffer is empty, so read data into it
        udi_vendor_bulk_out_run(dma_prog_buffers[usart_current_buffer].buf, 
            PROG_DMA_BUF_SIZE, fpga_prog_bulk_out_received);
        dma_prog_buffers[usart_current_buffer].state = DMA_PROG_BUF_FILLING;

        // this buffer is full, so start sending out the bitstream
        setup_usart_DMA(dma_prog_buffers[usb_current_buffer].buf, 
            dma_prog_buffers[usb_current_buffer].buflen);
        dma_prog_buffers[usb_current_buffer].state = DMA_PROG_BUF_EMPTYING;

        // other buffer is now being sent out over usart, this one is being filled by USB data
        uint8_t tmp = usart_current_buffer;
        usart_current_buffer = usb_current_buffer;
        usb_current_buffer = tmp;
    } else if (dma_prog_buffers[usart_current_buffer].state == DMA_PROG_BUF_FULL) {
        // if both buffers are full, empty this one
        setup_usart_DMA(dma_prog_buffers[usb_current_buffer].buf, 
            dma_prog_buffers[usb_current_buffer].buflen);
        dma_prog_buffers[usb_current_buffer].state = DMA_PROG_BUF_EMPTYING;

        // other buffer is still full, this one is being emptied
        // we still swap in this case
        uint8_t tmp = usart_current_buffer;
        usart_current_buffer = usb_current_buffer;
        usb_current_buffer = tmp;
    } else {
        // I think this has to be when the other buffer is emptying
        // in any case, we don't have anything to do
        return;
    }
}

enum FPGA_PROG_MODE {
    FPGA_PROG_MODE_SERIAL,
    FPGA_PROG_MODE_PARALLEL,
    FPGA_PROG_MODE_PARALLEL16
};

void selectmap_bulk_callback(udd_ep_status_t status, iram_size_t nb_transferred, udd_ep_id_t ep)
{
    if (UDD_EP_TRANSFER_OK != status) {
        return;
    }
    // udi_vendor_bulk_out_run(
    //     xram,
    //     sizeof(main_buf_loopback),
    //     selectmap_bulk_callback);
}

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
                    udd_ep_abort(UDI_VENDOR_EP_BULK_OUT);
                    #ifdef SERIAL_PROG_DMA
                        DMA_init();
                    #else
                    udi_vendor_bulk_out_run(
                            main_buf_loopback,
                            sizeof(main_buf_loopback),
                            main_vendor_bulk_out_received);
                    blockendpoint_usage = bep_fpgabitstream;
                    #endif
                    break;
                case FPGA_PROG_MODE_PARALLEL:
                case FPGA_PROG_MODE_PARALLEL16:
                    fpga_selectmap_setup2();
                    // gpio_configure_pin(PIN_EBI_NWE, PIO_OUTPUT_0);
                    udd_ep_abort(UDI_VENDOR_EP_BULK_OUT);
                    if (!udi_vendor_bulk_out_run(xram, 0xFFFFFFFF, selectmap_bulk_callback)) {
                        //todo error
                    }
                    break;
            }
            break;
        case 0xA2:
            if (FPGA_CURRENT_PROG_MODE == FPGA_PROG_MODE_SERIAL) {
                #ifdef SERIAL_PROG_DMA
                    DMA_shutdown();
                #endif
                blockendpoint_usage = bep_emem;
            } else if (FPGA_CURRENT_PROG_MODE == FPGA_PROG_MODE_PARALLEL) {
                udd_ep_abort(UDI_VENDOR_EP_BULK_OUT);
                fpga_selectmap_setup3();
                udi_vendor_bulk_out_run(
                        main_buf_loopback,
                        sizeof(main_buf_loopback),
                        main_vendor_bulk_out_received);
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