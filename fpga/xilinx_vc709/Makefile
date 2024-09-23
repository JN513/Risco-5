ifndef VIVADO_PATH
	VIVADO_PATH=vivado
endif

all: ./build/out.bit

./build/out.bit: buildFolder
	@echo "Building the Design..."
	$(VIVADO_PATH)/vivado  -mode batch -nolog -nojournal -source run.tcl
buildFolder:
	@echo "Creating the build folder..."
	mkdir -p build

clean:
	@echo "Cleaning the build folder..."
	rm -rf build

# openFPGALoader funciona apenas na versão nightly, a versão estavel atual não suporta a vc709 ainda
flash:
	@echo "Flashing the FPGA..."
	openFPGALoader -b vc709 ./build/out.bit
#$(VIVADO_PATH)/vivado  -mode batch -nolog -nojournal -source flash.tcl

run_all: ./build/out.bit flash