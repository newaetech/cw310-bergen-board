LOGFILE=make.log
WAVEFORMAT=fst
SEED=1
TIMEOUT=50000
DUMP=0

all: compile run

compile:
	iverilog -ccmdfile \
	tb.v \
	-g2005-sv \
	-Wportbind \
	-Wselect-range \
	-I../hdl/ \
	-I. \
	-P tb.pDUMP=$(DUMP) \
	-P tb.pSEED=$(SEED) \
	-P tb.pTIMEOUT=$(TIMEOUT) \

run:
	vvp -l$(LOGFILE) a.out -$(WAVEFORMAT)

lint:
	verilator --lint-only -Wall \
	-f cmdfile \
	-I../hdl \
	-I. \
	-D__ICARUS__ \
	--top-module cw310_top \
	2>&1 | tee lint.out \

clean:
	rm -f a.out
