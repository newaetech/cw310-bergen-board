## AES
- Standard, like the CW305 AES.
- Clocks controlled as on CW305, with J16 = DIP0 and K16 = DIP1.

## DDR3
- LVDS_XO_200M_ENA output: set by REG_XO_EN register (0x11)
- SYSCLK input monitoring: cycle counts per 2\*\*22 usb clocks: read REG_XO_FREQ
  register (0x12)
- enable self-test by setting REG_DDR3_EN (0xc)
- pass/fail status by reading REG_DDR3_PASS (0xe)
    - bit 1 reflects MIG's init_calib_complete
    - bit 0 high means test is passing -- continuously updated, but if a
      failure is seen, it sticks to 0 until FPGA is reset or DDR3 test is
      disabled and re-enabled
- doesn't cover the full address space or use random data (yet)

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

