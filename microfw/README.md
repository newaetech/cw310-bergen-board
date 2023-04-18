# SAM3X Microcontroller Firmware

<img src="../docs/SAM3Xoverview.png">

## Building the Firmware

CW340 firmware can be built by navigating to `src/` and running `make -j`. CW310 firmware can be built by running `make -j TARGET=CW310`.

## Functionality

The SAM3X microcontroller is responsible for many functions on the Bergen Board/CW340:

* Configuring/reconfiguring the FPGA via USB.
* Monitoring the FPGA temperature, controlling fans, shutting down power if entering over-temp situation that fans can't seem to control.
* Adjusting the core voltage.
* Controlling the on-board PLL to set required clock frequency.
* Allowing power cycling of the FPGA target.
* USB-serial ports for communication.
* Address/data bus which can be used as 30 computer-controller GPIO pins instead.
* Generic SPI interface.
* Detecting power brown-outs.
* Managing USB-C PD interface.

The CW340 differs from the CW310 in a few key ways relevant to the microcontroller:

* The FPGA is included on a daughterboard. This daughterboard also contains the TPS voltage regulator used for the FPGA's core voltage
* Control of a VFD display
* 8-bit/16-bit parallel programming for the FPGA instead of only serial
* A USB hub chip that also connects to an FTDI chip. This FTDI chip handles MPSSE programming and USART serial
* No USBC PD chip or USBC power port - the only power option is via a barrel jack.


### Configuring/reconfiguring the FPGA via USB.

On the CW310, this is done via SPI over USART2. See `src/naeusb/naeusb_fpga_target.c` for USB code and `src/naeusb/fpga_program.c` for programming code.

On the CW340, this can either be done via SPI on USART2 like on the CW310, or via the SelectMap interface. The latter uses the SMC peripheral on the SAM3X and
can do a 16-bit wide or 8-bit wide bus. See `src/naeusb_luna.c` for USB code and `src/naeusb/fpga_selectmap.c` for programming code.

### Monitoring the FPGA temperature, controlling fans, shutting down power if entering over-temp situation that fans can't seem to control.

Monitoring the temperature is done via some MAX1617 chips over I2C. The fan is controlled via PWM on timer TC0 and on PB25. There is also 
a pin change interrupt for the MAX1617 that shuts down power when detected, as well as a timer based one that periodically checks the MAX1617
and updates the LEDs. See `src/thermal_power.c` for this code.

### Adjusting the core voltage

Like with the CW305, a TPS56520 is used to provide the core voltage for the FPGA. Communication is done over I2C.

On the CW340, this chip is located on the daughter board and therefore may not always be present. The main code loop will attempt to set the
voltage repeatedly, until a successful attempt has been made.

See `src/naeusb/tps56520.c` for communication code and `src/naeusb/naeusb_fpga_target.c` for USB code.

### Controlling the on-board PLL to set required clock frequency.

Like with the CW305, the CW310 and CW340 include a CDCE906 PLL chip for providing a clock to the FPGA. The I2C communication code for this is located in
`src/naeusb/cdce906.c` and the USB code is located in `src/naeusb/naeusb_fpga_target.c`.

### USB-serial ports for communication.

On the CW310, two CDC serial ports are available for UART communication with the FPGA on USART0 and USART1. The USB part of 
this is mostly handled by the Microchip ASF HAL, with the USART code being handled in `src/naeusb/naeusb_usart.c`.

### Address/data bus which can be used as 30 computer-controller GPIO pins instead.

On both the CW310 and CW340, the static memory controller peripheral is used for most FPGA communication. The CW310 uses 8 pins for data transfer
(`PIN_EBI_DATA_BUS_DX`, X in `[0,7]`) and 20 pins for address selection (`PIN_EBI_ADDR_BUS_AX`, X in `[0,19]`) On the schematic, these are `USB_DX`
and `USB_AX`, respectively.

On the CW340, there is instead either 8 or 16 data pins, with the upper 8 pins either serving as data pins, or address pins.

Like with the CW305, general control of the GPIO pins is done in `src/naeusb/naeusb_fpga_target.c` and is available in 
Python via `io = target.gpio_mode()`. See the documentation for `chipwhisperer.capture.targets.CW310.FPGAIO for more information.

### Generic SPI interface.

General SPI communication is handled in `src/naeusb/naeusb_fpga_target.c` and is accessable via the 
generic IO interface. See the documentation for `chipwhisperer.capture.targets.CW310.FPGAIO for more information.

### Detecting power brown-outs.

The CW310/CW340 contains various fixed regulators and can detect power brownouts by interrupting on a change on these regulators'
PGOOD pins. The code for handling this is in `src/thermal_power.c`

### Managing USB-C PD interface.

The CW310 included a USBC port for powering the board. Control of this port is done via an STUSB4500, with communication code
being available in `src/usbc_pd.c`.

### VFD Display

The CW340 offers control of an optional VFD display on USART3. Code for this is contained in `src/VFD_display.c`.

## Interfaces

### A/D Interface & CW Interface

* Uses external address bus in SAM3X to provide high-speed data transfer option.

## USB-CDC Serial

* Presents 2x USB serial devices that FPGA can use.

## Power Management

Summary:

* Sets VCCINT value via I2C.
* Interrupts on "power good" indicator to detect power failures. If too many failures triggers "power down" mode (to prevent cycling of regulators).
* Controls LEDs to indicate to user any problems.

### Pins

LEDs(Outputs):

* Power Fail LED on `xxx`

Inputs:

* `PGOOD_VCCINT` on `PC16`
* `PGOOD_1V2` on `PC19`
* `PGOOD_1V8` on `PC20`
* `PGOOD_3V3` on `PB11`

Switches (pull-up needed, active-low):

* `PWRRESTART` on `PB23`

### Control Flow

**For PGOOD detection**:

1. Configure each input to be an interrupt, falling edge
2. On each falling edge, increment some counter.
3. Clear the counter to 0 every ~4 seconds.
4. If the counter ever reaches above some value, kill output.

### Thermal Management

Summary:

* Monitors the FPGA thermal die temperature, and turns on fan as required.
* If temperature gets too high, kills power to target side to protect FPGA.
* Controls LEDs.

#### Functions:

`read_temp()` : Reads temp from I2C sensor.

`set_fan_speed()` : Sets fan speed via PWM.

#### Temp Read

Temp sensor device is MAX1617 (I2C address should be set to `0x18`).

May need to configure temp limits on every start-up. Device has a local temp sensor can use for debug for now.

For remote sensor (not needed):

* Ideality factor = 1.010
* Series resistance = 2

#### Pins

`TEMP_ALERT_N` on `PA23`: Interrupt on thermal overload.

