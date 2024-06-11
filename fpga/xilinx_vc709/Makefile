all: ./build/out.bit

./build/out.bit: buildFolder
	/mnt/tools/Vivado19/Vivado/2019.1/bin/vivado  -mode batch -nolog -nojournal -source run.tcl
buildFolder:
	mkdir -p build

clean:
	rm -rf build

flash:
	/mnt/tools/Vivado19/Vivado/2019.1/bin/vivado  -mode batch -nolog -nojournal -source flash.tcl

run_all: ./build/out.bit flash