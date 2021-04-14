# SAM3X Microcontroller Firmware

<img src="../docs/SAM3Xoverview.png">

## Functionality

The SAM3X microcontroller is responsible for many functions on the Bergen Board:

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