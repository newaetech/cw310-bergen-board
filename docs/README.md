# CW310 Bergen Board (Kintex FPGA Target)

## Block Diagram & Overview

<img src="CW310block.png">

## Power Monitoring

The CW310 includes the following power supplies:

The power good outputs are monitored by the microcontroller. If they cycle several times (indicating the device is struggling to maintain power), the device goes into fail-safe mode.

## Heat Monitoring

The CW310 integrates a FPGA thermal monitor, and turns on fans as required. If the temperature gets too high, it also kills power to target side to protect FPGA from cooking.

The CW310 can be configured to use one of four fans (all are driven from the same signal):

* Top-side cross-flow fan (for heatsink or exposed die back).
* Top-side heatsink mounted fan.
* Bottom-side cross-flow fan (best with heatsink).
* Bottom-side heatsink mounted fan.

The two LEDs indicate the thermal status:

1. Green = temperature is below 60C.
2. Red solid = temperature is 60C to 75C.
3. Red blinking = temperature is above 75C.

Once the temperature is above 80C the power is immediately cut to the target device. The die temperature is still reflected in the LED state, but you will need to press the `Restart Power` button to bring the target power back (also can be done via API call).

## Configuration Options

## Power Analysis

## Serial Port / Debug

## SRAM

## DDR3

## Expansion Headers
