#include <asf.h>
#include "circbuffer.h"

void vfd_init(void)
{
    // NOTE: just in case, short the DISPLAY_BUSY pin since it might be at 2.5V
    gpio_configure_pin(PIN_DISPLAY_BUSY, PIN_DISPLAY_BUSY_FLAGS);
    gpio_configure_pin(PIN_DISPLAY_TX, PIN_DISPLAY_TX_FLAGS);
    gpio_configure_pin(PIN_DISPLAY_NRST, PIO_TYPE_PIO_OUTPUT_0);
    gpio_configure_pin(PIN_DISPLAY_ON, PIN_DISPLAY_ON_FLAGS);
    gpio_configure_pin(PIN_DISPLAY_ON, PIO_TYPE_PIO_OUTPUT_1);
    sysclk_enable_peripheral_clock(ID_USART3);

    sam_usart_opt_t vfd_opts;
    vfd_opts.baudrate = 38400;
    vfd_opts.stop_bits = US_MR_NBSTOP_1_BIT;
    vfd_opts.parity_type = US_MR_PAR_NO;
    vfd_opts.char_length = US_MR_CHRL_8_BIT;
    vfd_opts.channel_mode = US_MR_CHMODE_NORMAL;

    usart_init_rs232(USART3, &vfd_opts, sysclk_get_cpu_hz());
    usart_enable_tx(USART3);

    
    // NOTE - there's a delay requirement between this init and vfd_write
}



void vfd_write(char *str)
{
    while (*str) {
        while (!(usart_get_status(USART3) & US_CSR_TXRDY));
        usart_putchar(USART3, *str++);
    }
}