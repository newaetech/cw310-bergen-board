#include <asf.h>
#include <stdint.h>
#include <string.h>
#include "circbuffer.h"
#include "VFD_display.h"

void vfd_write(char *str)
{
    while (*str) {
        while (!(usart_get_status(USART3) & US_CSR_TXRDY));
        usart_putchar(USART3, *str++);
    }
}


static void initPort() {
    gpio_configure_pin(PIN_DISPLAY_BUSY, PIN_DISPLAY_BUSY_FLAGS);
    gpio_configure_pin(PIN_DISPLAY_TX, PIN_DISPLAY_TX_FLAGS);
    gpio_configure_pin(PIN_DISPLAY_NRST, PIO_TYPE_PIO_OUTPUT_0); //nRST inverted
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
}

static void writePort(uint8_t data) {
    while (!(usart_get_status(USART3) & US_CSR_TXRDY));
    usart_putchar(USART3, data);
}

static void hardReset() {
    initPort();
    gpio_set_pin_high(PIN_DISPLAY_NRST); //sets NRST on VFD low
    delay_ms(2);
    gpio_set_pin_low(PIN_DISPLAY_NRST); //sets NRST on VFD high
    delay_ms(120);
}


/* Private functions for this file*/

static void command(uint8_t data)
{
    writePort(data);
}
static void command_xy(uint16_t x, uint16_t y) {
    command(x);
    command(x>>8);
    y /= 8;
    command(y);
    command(y>>8);
}
static void command_xy1(uint16_t x, uint16_t y) {
    command(x);
    command(x>>8);
    command(y);
    command(y>>8);
}

static void us_command(uint8_t group, uint8_t cmd) {
   command(0x1f);
   command(0x28);
   command(group);
   command(cmd);
}

static void commandprefixgroup(uint8_t prefix, uint8_t group, uint8_t cmd) {
   command(prefix);
   command(group);
   command(cmd);
}

/* Public Functions */

void GU7000_back() {
    command(0x08);
}

void GU7000_forward() {
    command(0x09);
}

void GU7000_lineFeed() {
    command(0x0a);
}

void GU7000_home() {
    command(0x0b);
}

void GU7000_carriageReturn() {
    command(0x0d);
}

void GU7000_setCursor(uint16_t x, uint16_t y) {
    command(0x1f);
    command('$');
    command_xy(x, y);
}

void GU7000_clearScreen() {
    command(0x0c);
}

void GU7000_cursorOn() {
    commandprefixgroup(0x1f, 'C', 1);
}

void GU7000_cursorOff() {
    commandprefixgroup(0x1f, 'C', 0);
}

void GU7000_init() {
    delay_ms(NORITAKE_VFD_RESET_DELAY);
    initPort();
    command(0x1b);
    command('@');
}

void GU7000_reset() {
    hardReset();
}

void GU7000_useMultibyteChars(bool enable) {
    #if (NORITAKE_VFD_MODEL_CLASS-7000)/100==9 || (NORITAKE_VFD_MODEL_CLASS-7000)/100==1
        us_command('g', 0x02);
        command(enable);
    #endif
}

void GU7000_setMultibyteCharset(uint8_t code) {
    #if (NORITAKE_VFD_MODEL_CLASS-7000)/100==9 || (NORITAKE_VFD_MODEL_CLASS-7000)/100==1
        us_command('g', 0x0f);
        command(code);
    #endif
}

void GU7000_useCustomChars(bool enable) {
    commandprefixgroup(0x1b, '%', enable);
}

static inline uint8_t getColumn(const uint8_t *src, int col) {
    uint8_t out = 0;
    for (int i=0; i<8; i++)
        if (src[i] & (1<<(4-col))) out += 1<<(7-i);
    return out;
}

void GU7000_defineCustomChar(uint8_t code, FontFormat format, const uint8_t *data) {
    commandprefixgroup(0x1b, '&', 0x01);
    command(code);
    command(code);

    switch (format) {
    case CUUFormat:
        command(5);
        for (uint8_t i=0; i<5; i++)
            command(getColumn(data, i));
        break;

    case GU70005x7Format:
        command(5);
        GU7000_printlen((const char*)data, 5);
        break;
    case GU70007x8Format:
        command(7);
        GU7000_printlen((const char*)data, 7);
        break;
    }
}

void GU7000_deleteCustomChar(uint8_t code) {
    commandprefixgroup(0x01b, '?', 0x01);
    command(code);
}

void GU7000_setAsciiVariant(AsciiVariant code) {
    commandprefixgroup(0x1b, 'R', code);
}

void GU7000_setCharset(Charset code) {
    commandprefixgroup(0x1b, 't', code);
}

void GU7000_setScrollMode(ScrollMode mode) {
    command(0x1f);
    command(mode);
}

void GU7000_setHorizScrollSpeed(uint8_t speed) {
    commandprefixgroup(0x1f, 's', speed);
}

void GU7000_invertOff() {
    commandprefixgroup(0x1f, 'r', 0);
}

void GU7000_invertOn() {
    commandprefixgroup(0x1f, 'r', 1);
}

void GU7000_setCompositionMode(CompositionMode mode) {
    commandprefixgroup(0x1f, 'w', mode);
}

void GU7000_setScreenBrightness(uint16_t level) {
    if (level == 0)
        GU7000_displayOff();
    else if (level <= 100) {
        GU7000_displayOn();
        commandprefixgroup(0x1f, 'X', (level*10 + 120)/125);
    }
}

void GU7000_wait(uint8_t time) {
    us_command('a', 0x01);
    command(time);
}

void GU7000_scrollScreen(uint16_t x, uint16_t y, uint16_t times, uint8_t speed) {
    uint16_t pos = (x*NORITAKE_VFD_LINES)+(y/8);
    us_command('a', 0x10);
    command(pos);
    command(pos>>8);
    command(times);
    command(times>>8);
    command(speed);
}

void GU7000_blinkScreen() {
    us_command('a', 0x11);
    command(0);
    command(0);
    command(0);
    command(0);
}

void GU7000_displayOff() {
    us_command('a', 0x40);
    command(0);
}

void GU7000_displayOn() {
    us_command('a', 0x40);
    command(0x01);
}

void GU7000_screenSaver(ScreenSaver mode) {
    us_command('a', 0x40);
    command(mode);
}

void GU7000_setFontStyle(bool proportional, bool evenSpacing) {
    us_command('g', 0x03);
    command(proportional*2 + evenSpacing);
}

void GU7000_setFontSize(uint8_t x, uint8_t y, bool tall) {
    if (x<=4 && y<=2) {
        us_command('g', 0x40);
        command(x);
        command(y);
        #if (NORITAKE_VFD_MODEL_CLASS-7000)/100==9 || (NORITAKE_VFD_MODEL_CLASS-7000)/100==1
            us_command('g', 0x01);
            command(tall+1);
        #endif
    }
}

void GU7000_selectWindow(uint8_t window) {
    if (window <= 4)
        command(0x10 + window);
}

void GU7000_defineWindow(uint8_t window, uint16_t x, uint16_t y, uint16_t width, uint16_t height) {
    us_command('w', 0x02);
    command(window);
    command(0x01);
    command_xy(x, y);
    command_xy(width, height);
}

void GU7000_deleteWindow(uint8_t window) {
    us_command('w', 0x02);
    command(window);
    command(0);
    command_xy(0, 0);
    command_xy(0, 0);
}

void GU7000_joinScreens() {
    us_command('w', 0x10);
    command(0x01);
}

void GU7000_separateScreens() {
    us_command('w', 0x10);
    command(0);
}

void GU7000_prints(char *c) {
    while(*c){
        command(*c++);
    }
}

void GU7000_printlen(char * c, unsigned int len) {

    while(len){
        writePort(*(c++));
        len--;
    }
}

void GU7000_drawImage_ram(uint16_t width, uint8_t height, const uint8_t *data) {
    if (height > NORITAKE_VFD_HEIGHT) return;
    us_command('f', 0x11);
    command_xy(width, height);
    command((uint8_t) 1);
    for (unsigned i = 0; i<(height/8)*width; i++)
        command(data[i]);
}

void GU7000_drawFROMImage(unsigned long address, uint8_t srcHeight, uint16_t width, uint8_t height) {
    #if (NORITAKE_VFD_MODEL_CLASS-7000)/100==9 || (NORITAKE_VFD_MODEL_CLASS-7000)/100==1
        if (height > NORITAKE_VFD_HEIGHT) return;
        us_command('f', 0x10);
        command(0x01);
        command(address);
        command(address>>8);
        command(address>>16);
        command(srcHeight/8);
        command((srcHeight/8)>>8);
        command_xy(width, height);
        command((uint8_t) 1);
    #endif
}

void GU7000_fillRect(uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1, bool on) {
    x0 = min(NORITAKE_VFD_WIDTH, x0);
    x1 = min(NORITAKE_VFD_WIDTH, x1);
    y0 = min(NORITAKE_VFD_HEIGHT, y0);
    y1 = min(NORITAKE_VFD_HEIGHT, y1);
    if (y1<=y0 || x1<=x0) return;
    uint8_t bufw = 8, bufh = (y1-y0+7)/8*8;
    uint8_t *buf = (uint8_t*)alloca(bufh/8 * bufw);
    for (unsigned x = 0; x < x1-x0; x += bufw) {
        uint8_t part = (x + bufw < x1-x0)? bufw: (x1-x0) - x;
        memset(buf, 0, bufh/8 * bufw);
        if (on)
            for (uint8_t col = 0; col < part; col++) {
                for (uint8_t py = y0 % 8; py < y0 % 8 + min(y1-y0, 8); py++)
                    buf[col*bufh/8] |= 1 << (7-py);
                for (uint8_t row = (y0+7)/8; row < y1/8; row++)
                    buf[row - y0/8 + col*bufh/8] = 0xff;
                if (y0/8 != y1/8)
                    for (uint8_t py = 0; py < y1 % 8; py++)
                        buf[(y1-y0)/8 + col*bufh/8] |= 1 << (7-py);
            }
        GU7000_setCursor(x + x0, y0);
        GU7000_drawImage_ram(bufw, bufh, buf);
    }
}