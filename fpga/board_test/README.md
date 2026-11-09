# Overview

## AES
- Standard, like the CW305 AES.
- Clocks controlled as on CW305, with J16 = DIP0 and K16 = DIP1.

## DDR3
- `LVDS_XO_200M_ENA` output: set by `REG_XO_EN` register (0x11) bit 0
- `VDDR_ENABLE`: set by `REG_XO_EN` register (0x11) bit 1
- `VDDR_PGOOD` can be read at `REG_VDDR_PGOOD` register (0x16)
- `SYSCLK` input monitoring: cycle counts per 2\*\*22 usb clocks: read `REG_XO_FREQ`
  register (0x12)
- enable self-test by setting `REG_DDR3_EN` (0xc)
- pass/fail status by reading `REG_DDR3_PASS` (0xe)
    - bit 1 reflects MIG's `init_calib_complete`
    - bit 0 high means test is passing -- continuously updated, but if a
      failure is seen, it sticks to 0 until FPGA is reset or DDR3 test is
      disabled and re-enabled
- doesn't cover the full address space or use random data (yet)

## DIP switches
- their state can be read from `REG_DIP` (0x10)

## LEDs
- set via `REG_LEDS` (0x13), *except* if `REG_HEARTBEATS` (0x14) is set, in which
  case LED0 is USB clock heartbeat and LED1 is crypto clock heartbeat

## SRAM
- enable self-test by setting `REG_SRAM_EN` (0xd)
- pass/fail status by reading `REG_SRAM_PASS` (0xf)
    - 1 means test is passing -- continuously updated, but if a failure is
      seen, it sticks to 0 until FPGA is reset or SRAM test is disabled and
      re-enabled
    - does a write of the full SRAM, followed by a read and verify of the
      full SRAM, using LFSR-generated data, continuously when enabled
    - driven by USB clock
    - read/write of the full memory takes about 1 second


# Vivado Issues
If you require ILAs, Vivado 2026 licensing changes have complicated building
the bitfiles.

In previous versions, a "Vivado ML Enterprise Edition" license was needed for
the larger `xc7k410tfbg676` FPGA.

With Vivado 2026, the `xc7k410tfbg676` is now covered by the free license, but
this license does not allow for our ILAs to be included.

We have therefore disabled the ILAs from the project file. These are the
defines that we previously used to aid in debugging:
- `ILA_REG`
- `ILA_USB`
- `ILA_CRYPTO`
- `ILA_SRAM`
- `ILA_DDR3`
- `ILA_XADC_DRP`

The project file has been updated to use Vivado 2026; if you wish to use an
older Vivado version, it should be easy to re-build the project file from
scratch. You can look to the version of the project file used on commit
`828a25b419b4a19c7cb4bbe5cf4ae53433eea320`, but be aware that the repository
has received updates since.

In order to re-build with ILAs, the easiest path is likely to use a pre-2026
version of Vivado with the free license and target the smaller `xc7k160tfbg676`
variant.

