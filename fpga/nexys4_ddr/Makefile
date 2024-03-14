all: ./build/out.bit

./build/out.bit: buildFolder
	vivado -mode batch -nolog -nojournal -source run.tcl
buildFolder:
	mkdir -p build

clean:
	rm -rf build
	rm clockInfo.txt

flash:
	openFPGALoader -b nexys_a7_100 ./build/out.bit

run_all: ./build/out.bit flash