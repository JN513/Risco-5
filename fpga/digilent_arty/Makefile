ifndef VIVADO_PATH
	VIVADO=vivado
else
	VIVADO=$(VIVADO_PATH)/vivado
endif

all: ./build/out.bit

./build/out.bit: buildFolder
	$(VIVADO) -mode batch -nolog -nojournal -source run.tcl
buildFolder:
	mkdir -p build

clean:
	rm -rf build
	rm clockInfo.txt

load:
	openFPGALoader -b arty_a7_100t ./build/out.bit

run_all: ./build/out.bit load