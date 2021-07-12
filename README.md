# CW310 - Kintex FPGA ('Bergen Board') Target

![](docs/Images/cw310-bergenk410t.jpeg)

Full documentation for this board is rendered at [https://rtfm.newae.com/Targets/CW310 Bergen Board](https://rtfm.newae.com/Targets/CW310%20Bergen%20Board/), please see that site for documentation.

## Quick Start

## Python Interface

## Documentation

The documentation in the `docs` folder is rendered to [https://rtfm.newae.com/Targets/CW310 Bergen Board](https://rtfm.newae.com/Targets/CW310%20Bergen%20Board/), the github markdown is missing some features that markdown file is designed for.

### Schematic

* [View schematics online](https://github.com/newaetech/cw310-bergen-board/blob/main/docs/BergenBoard_Rev06C.PDF)
* [Download PDF of Schematics](https://github.com/newaetech/cw310-bergen-board/raw/main/docs/BergenBoard_Rev06C.PDF)

### Xilinx XDC Constraints file

* [Vivado XDC Constraint File](https://github.com/newaetech/cw310-bergen-board/tree/main/pins)

### Local documentation editing

The actual docs are served from rtfm.newae.com and not based on the mkdocs file in this repo. But if editing docs for the CW310, you might want to use:

```
pip install mkdocs-material markdown-include mkdocs-exclude yafg
mkdocs serve
```
