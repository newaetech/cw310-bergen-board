ifeq ($(TARGET),CW340)
	SRC += naeusb/fpga_selectmap.c VFD_display.c main_cw340.c naeusb_luna.c
else ifeq ($(TARGET),CW310)
	SRC += usbc_pd.c main_cw310.c naeusb/naeusb_mpsse.c
else
$(error compile with TARGET=CW340 or TARGET=CW310)
endif

SRC += naeusb/circbuffer.c fpgautil_io.c naeusb_bergen.c
SRC += tasks.c thermal_power.c timers.c

SRC += naeusb/circbuffer.c naeusb/udc.c naeusb/naeusb.c naeusb/naeusb_default.c naeusb/naeusb_usart.c naeusb/naeusb_fpga_target.c
SRC += naeusb/usb_xmem.c naeusb/fpga_program.c naeusb/fpgaspi_program.c naeusb/tps56520.c naeusb/cdce906.c naeusb/i2c_util.c

LINKERFILE = naeusb/flash_sam3x8.ld

include naeusb/makefile.cw