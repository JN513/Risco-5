all: ./impl/pnr/project.fs

./impl/pnr/project.fs: buildFolder
	gw_sh run.tcl
buildFolder:
	mkdir -p build

clean:
	rm -rf build

flash:
	openFPGALoader -b tangnano20k ./impl/pnr/project.fs

run_all: ./impl/pnr/project.fs flash