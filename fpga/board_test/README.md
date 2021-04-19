## AES
- Standard, like the CW305 AES.
- Clocks controlled as on CW305, with J16 = DIP0 and K16 = DIP1.

## DDR3
- LVDS_XO_200M_ENA output: set by REG_XO_EN register (0x11)
- TODO: SYSCLK input monitoring: cycle counts per XXX usb clocks: read REG_XO_FREQ
  register (0x12)
- self-test: TODO

## DIP switches
- their state can be read from REG_DIP (0x10)

## LEDs
- set via REG_LEDS (0x13), *except* if REG_HEARTBEATS (0x14) is set, in which
  case LED0 is USB clock heartbeat and LED1 is crypto clock heartbeat

## SRAM
- enable self-test by setting REG_SRAM_EN (0xd)
- pass/fail status by reading REG_SRAM_PASS (0xf)
    - 1 means test is passing -- continuously updated, but if a failure is
      seen, it sticks to 0 until FPGA is reset or SRAM test is disabled and
      re-enabled
    - does a write of the full SRAM, followed by a read and verify of the
      full SRAM, using LFSR-generated data, continuously when enabled
    - driven by USB clock
    - read/write of the full memory takes about 1 second
- haven't tested this on hardware, so there's an ILA just in case

