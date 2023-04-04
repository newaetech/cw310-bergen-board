#pragma once

#include "VFD_display_config.h"

void vfd_write(char *str);

#include <stdint.h>
#include <stddef.h>

typedef enum ImageMemoryArea {
    FlashImageArea = 1,
    ScreenImageArea = 2
} ImageMemoryArea;

typedef enum ScrollMode {
    WrappingMode =    1,
    VertScrollMode =  2,
    HorizScrollMode = 3
} ScrollMode;

typedef enum CompositionMode {
    NormalCompositionMode = 0,
    OrCompositionMode =     1,
    AndCompositionMode =    2,
    XorCompositionMode =    3
} CompositionMode;

typedef enum ScreenSaver {
    AllDotsOffSaver = 2,
    AllDotsOnSaver =  3,
    InvertSaver =   4
} ScreenSaver;

typedef enum LEDColor {
    NoLight =       0x000,
    BlueLight =     0x00f,
    GreenLight =    0x0f0,
    CyanLight =     0x0ff,
    RedLight =      0xf00,
    MagentaLight =  0xf0f,
    SmokeLight =    0xfff
} LEDColor;

typedef enum FontFormat {
     GU70005x7Format =0,
     GU70007x8Format =1,
     CUUFormat =    2,
     LCDFormat =    CUUFormat
} FontFormat;

typedef enum AsciiVariant {
    AmericaAscii =  0,
    FranceAscii =   1,
    GermanyAscii =  2,
    EnglandAscii =  3,
    Denmark1Ascii = 4,
    SweedenAscii =  5,
    ItalyAscii =    6,
    Spain1Ascii =   7,
    JapanAscii =    8,
    NorwayAscii =   9,
    Denmark2Ascii = 10,
    Spain2Ascii =   11,
    LatinAmericaAscii = 12,
    KoreaAscii = 13
} AsciiVariant;

typedef enum Charset {
    CP437 = 0, EuroStdCharset = CP437,
    Katakana = 1,
    CP850 = 2, MultilingualCharset = CP850,
    CP860 = 3, PortugeseCharset = CP860,
    CP863 = 4, CanadianFrenchCharset = CP863,
    CP865 = 5, NordicCharset = CP865,
    CP1252 = 0x10,
    CP866 = 0x11, Cyrillic2Charset = CP866,
    CP852 = 0x12, Latin2Charset = CP852,
    CP858 = 0x13
} Charset;

    void GU7000_back();
    void GU7000_forward();
    void GU7000_lineFeed();
    void GU7000_home();
    void GU7000_carriageReturn();
    void GU7000_setCursor(uint16_t x, uint16_t y);
    void GU7000_clearScreen();
    void GU7000_cursorOn();
    void GU7000_cursorOff();
    void GU7000_init();
    void GU7000_reset();
    void GU7000_useMultibyteChars(bool enable);
    void GU7000_setMultibyteCharset(uint8_t code);
    void GU7000_useCustomChars(bool enable);
    void GU7000_defineCustomChar(uint8_t code, FontFormat format, const uint8_t *data);
    void GU7000_deleteCustomChar(uint8_t code);
    void GU7000_setAsciiVariant(AsciiVariant code);
    void GU7000_setCharset(Charset code);
    void GU7000_setScrollMode(ScrollMode mode);
    void GU7000_setHorizScrollSpeed(uint8_t speed);
    void GU7000_invertOn();
    void GU7000_invertOff();
    void GU7000_setCompositionMode(CompositionMode mode);
    void GU7000_setScreenBrightness(uint16_t level);
    void GU7000_wait(uint8_t time);
    void GU7000_scrollScreen(uint16_t x, uint16_t y, uint16_t count, uint8_t speed);
    void GU7000_blinkScreen();
    void GU7000_displayOn();
    void GU7000_displayOff();
    void GU7000_screenSaver(ScreenSaver mode);
    void GU7000_drawImage_ram(uint16_t width, uint8_t height, const uint8_t *data);
    void GU7000_drawFROMImage(unsigned long address, uint8_t srcHeight, uint16_t width, uint8_t height);
    void GU7000_setFontStyle(bool proportional, bool evenSpacing);
    void GU7000_setFontSize(uint8_t x, uint8_t y, bool tall);
    void GU7000_selectWindow(uint8_t window);
    void GU7000_defineWindow(uint8_t window, uint16_t x, uint16_t y, uint16_t width, uint16_t height);
    void GU7000_deleteWindow(uint8_t window);
    void GU7000_joinScreens();
    void GU7000_separateScreens();
    void GU7000_printlen(char * c, unsigned int len);
    void GU7000_prints(char * c);
    void GU7000_fillRect(uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1, bool on);

    void GU7000_drawImage_xy(uint16_t x, uint8_t y, uint16_t width, uint8_t height, const uint8_t *data);
    void GU7000_drawImage_memarea_offset(uint16_t x, uint8_t y, ImageMemoryArea area, unsigned long address, uint8_t srcHeight, uint16_t width, uint8_t height, uint16_t offsetx, uint16_t offsety);
    void GU7000_drawImage_memarea(uint16_t x, uint8_t y, ImageMemoryArea area, unsigned long address, uint16_t width, uint8_t height);
