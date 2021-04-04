# CW310 - Kintex FPGA ('Bergen Board') Target

![](docs/Images/cw310-bergenk410t.jpeg)

Full documentation for this board is rendered at [https://rtfm.newae.com/Targets/CW310 Bergen Board](https://rtfm.newae.com/Targets/CW310%20Bergen%20Board/), please see that site for documentation.

## Quick Start

## Python Interface

## Documentation

The documentation in the `docs` folder is rendered to [https://rtfm.newae.com/Targets/CW310 Bergen Board](https://rtfm.newae.com/Targets/CW310%20Bergen%20Board/), the github markdown is missing some features that markdown file is designed for.

### Schematic

You can find a [PDF Schematic](docs/BergenBoard_Rev06.PDF) in this repo.

### Local documentation editing

The actual docs are served from rtfm.newae.com and not based on the mkdocs file in this repo. But if editing docs for the CW310, you might want to use:

```
pip install mkdocs-material markdown-include mkdocs-exclude yafg
mkdocs serve
```