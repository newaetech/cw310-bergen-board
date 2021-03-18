# CW310 Bergen Board (Kintex FPGA Target)

## Block Diagram & Overview

<img src="CW310block.png">

## Power Supplies & Monitoring

The CW310 includes the following power supplies:

* 8-20V input --> 5V output
* 5V --> 1V VCC-INT (10A)
* 5V --> 1.8V Aux
* 5V --> 3.3V I/O voltage
* 5V --> 1.2V spare

The normal operating mode of the board is to use a higher voltage input, supplied from a USB-C wall adapter or DC barrel jack, which generates the main 5V supply for the board. This configuration is set by switch XXXX as shown here:

XXXX

As an alternative, you can also take the 5V supply from the "control" USB-C controller. This is normally not recommended, as the current requirement can exceed what a typical computer/laptop is willing to supply out of it's USB-C port (and even worse if you use the USB-A to USB-C adapter).

### Power Good Monitoring

The power good outputs are monitored by the microcontroller. If they cycle several times (indicating the device is struggling to maintain power), the device goes into fail-safe mode which shuts off the target power. This will often occur if your source power supply is insufficient, but could also indicate a short (such as an accessory board is shorting out).

Double-check the setting of the 5V source switch - be sure you are using the on-board 5V regulator instead of just taking power from the control USB-C port.

### USB-C PD Profiles

If using the USB-C power-only port, the board will attempt to request one of these power profiles:

* TODO


## Thermal

The CW310 integrates a FPGA thermal monitor, and turns on fans as required. If the temperature gets too high, it also kills power to target side to protect the FPGA from cooking itself.

### Fans

Due to the access required to the FPGA top-side when performing certain security evaluation work, the CW310 can be physically set up to use one of four fans (all four are driven from the same signal):

* Top-side cross-flow fan (for heatsink or exposed die back).
* Top-side heatsink mounted fan.
* Bottom-side cross-flow fan (best with heatsink).
* Bottom-side heatsink mounted fan.

TODO - fan header

### Heatsink

The board is designed to work with XXXX TODO.

### Thermal Monitoring

The two LEDs indicate the thermal status:

1. Green = temperature is below 60C.
2. Red solid = temperature is 60C to 75C.
3. Red blinking = temperature is above 75C.

Once the temperature is above 80C the power is immediately cut to the target device. The die temperature is still reflected in the LED state, but you will need to press the `Restart Power` button to bring the target power back (also can be done via API call).

You can read the FPGA temperature from the Python API as well.

## Configuration Options

The mode switches on the bottom of the board allow you to set the M0/M1/M2 pins. Note that the microcontroller can override the DIP switch settings - this is done to make it easier to work with the board, as you don't need to worry about changing the switches if you want to switch from one mode to another.

If you use the Python API to configure the device, it will automatically override the mode switches to what Xilinx calls "slave serial" mode (referred to as "controller driven" for clarity here) for example. This serial mode is the *default and supported configuration mode* for most users.

### Controller Driven Serial Configuration

The default mode of loading a bitstream into the board is over the USB interface, which happens with the Python API. This allows simple integration of your target into a larger test environment without relying on additional connections.

This configuration is moderately fast - the current firmware loads an uncompressed K160T bitstream in XX seconds, and an uncompressed K410T bitstream in XX seconds. The bitstream compression feature can be enabled which results in significant loading time improvements, especially for small designs. 

TODO TEST

### Configuration Failure Detection

Two methods are used to detect configuration failure. The most basic is the `DONE` pin, which goes high when the device is configured successfully. When the `DONE` pin goes high LED `XXX` will also *turn off*.

### Configuration Signal Breakout


### Xilinx JTAG Configuration & Debug

A standard 14-pin Xilinx JTAG header is provided, which also allows usage of debug tools such as ILA cores via a Xilinx Platform USB Cable (not included). Note you can still configure the FPGA via the USB interface even if using the JTAG header for debug access.

## Power Analysis Options

## USB Interface (via SAM3X)

The CW310 integrates a SAM3X microcontroller that provides the host USB interface. This microcontroller is preloaded with firmware that provides features such as:

* High-speed USB interface to computer.
* Management of power, PLL, and thermal monitoring chips.
* Simple address/data bus to read/write data into FPGA.
* FPGA configuration.

The firmware written to the SAM3X is open source and can be modified for your own use. This microcontroller can also be used to perform ultra high speed captures, by offloading the test vector generation onto the microcontroller itself.

For more information on the USB/SAM3X microcontroller, see the `microfw` directory.

### USB Serial Ports

The SAM3X exposes two USB-CDC serial ports with the default firmware. On plugging the USB-C data connector in, you should see two USB serial ports on your host. These ports are connected on the FPGA as follows:

TODO

These should act as normal serial ports, with a configurable baud rate from the host computer. Note that as these are implemented in the SAM3X you can modify them to route the serial data to another location instead of USB, or perform any filtering or processing you require.

### Ethernet MAC/PHY

The SAM3X includes a 10/100 Ethernet MAC & PHY. This is currently unused with the default firmware, but you can use this to provide the same features as the USB interface but over Ethernet (helpful for using many target boards).

## User QSPI & MicroSD Card

A user QSPI socket is present, tested with XXXX. This is designed to fit standard 6x8 WSON package QSPI chips. The expected pinout of the chip is as follows:

TODOXXX

In addition, a MicroSD card is also present for user use. The connection between QSPI and FPGA is given below:

TODOXXX

Both of these devices connect to the same FPGA bank, which has a voltage level set with XXXX. The voltage level for this bank also routes to the MicroSD and QSPI VCC pin - confirm the expected voltage before using these peripherals!

## User Expansion Headers A / B

Two expansion headers are provided, which use standard 0.05" (1.27mm) pitch headers. These allow mating of either daughter boards or cables as required.

Each header can be set to a separate I/O level, as each header routes to a different FPGA bank. 

## User PMOD Headers

Two PMOD headers are provided on the board. These provide 16 digital I/O signals (8 per header) along with 3.3V and GND pins. The I/O level for these headers is always 3.3V.

## User JTAG Headers

For soft-core implementations, several standard JTAG headers are provided on the board. Three standard headers are provided which reflect:

* 20-pin 0.1" JTAG (Arm Standard)
* 10-pin 0.05" JTAG/SWD (Arm Cortex-M)
* 20-pin 0.05" Trace/SWD (Arm Cortex-M)

Each of these includes a VCC pin. Switch XXX sets if the VCC pin is driven from the board with 3.3V (XXXX setting), or if it connects via a resistor to FPGA pin XXXXX to use for sensing purposes. Normally if you are implementing a soft-core & using the debug header, your debugger will require you to drive the VCC pin with 3.3V for detection.



## User USB

An additional USB-C connector is provided that allows you to route a user USB signal.

## SRAM

## DDR3