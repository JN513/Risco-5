
all: ./build/out.fs

./build/out.fs: ./build/out_pnr.json
	gowin_pack -d GW2AR-LV18QN88C8/I7 ./build/out_pnr.json  -o ./build/out.fs

./build/out_pnr.json: ./build/out.json
	nextpnr-ecp5 --json ./build/out.json --write ./build/out_pnr.json \
		--cst pinout.cst --device GW2AR-LV18QN88C8/I7 --lpf-allow-unconstrained

./build/out.json: main.v pinout.cst buildFolder
	yosys -p " \
		read_verilog main.v; \
		read_verilog ../../debug/reset.v; \
		read_verilog ../../src/core/*.v; \
		read_verilog ../../src/peripheral/*.v; \
		synth_gowin -json ./build/out.json -abc9 \
	"

buildFolder:
	mkdir -p build

clean:
	rm -rf build

flash:
	openFPGALoader -b tangnano20k ./build/out.fs

run_all: ./build/out.fs flash