/* 
ChipWhisperer Artix Target - Register address definitions for reference target.

Copyright (c) 2020, NewAE Technology Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted without restriction. Note that modules within
the project may have additional restrictions, please carefully inspect
additional licenses.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied, of NewAE Technology Inc.
*/

// *** WARNING***  
// Two identical copies are maintained in this repo: 
// - one in software/chipwhisperer/capture/targets/defines/, used by CW305.py at runtime
// - one in hardware/victims/cw305_artixtarget/fpga/common/, used by Vivado when building the bitfile
// Ideally we could use a symlink but that doesn't work on Windows. There are solutions to that 
// (https://stackoverflow.com/questions/5917249/git-symlinks-in-windows) but they have their own risks.
// Since this is the only symlink candidate in this repo at this moment, it seems easier/less risky
// to deal with having two files.

`define REG_CLKSETTINGS                 'h00
`define REG_USER_LED                    'h01
`define REG_BUILDTIME                   'h0b
`define REG_DDR3_EN                     'h0c
`define REG_DDR3_PASS                   'h0e
`define REG_DIP                         'h10
`define REG_XO_EN                       'h11
`define REG_LEDS                        'h13
`define REG_HEARTBEATS                  'h14
`define REG_VDDR_PGOOD                  'h16
`define REG_XADC_DRP_ADDR               'h17
`define REG_XADC_DRP_DATA               'h18
`define REG_XADC_STAT                   'h19

`define REG_DDR3_CLEAR_FAIL             'h20
`define REG_DDR3_ITERATIONS             'h21
`define REG_DDR3_ERRORS                 'h22
`define REG_DDR3_ERROR_ADDR             'h23
`define REG_DDR3_STAT                   'h24
`define REG_DDR3_READ_READ              'h25
`define REG_DDR3_READ_IDLE              'h26
`define REG_DDR3_WRITE_WRITE            'h27
`define REG_DDR3_WRITE_IDLE             'h28
`define REG_DDR3_READ_MAX_STALL_COUNT   'h29
`define REG_DDR3_WRITE_MAX_STALL_COUNT  'h2a
`define REG_DDR3_UI_CLK_FREQUENCY       'h2b
`define REG_USB_CLK_FREQUENCY           'h2c
`define REG_SYS_CLK_FREQUENCY           'h2d


