ifndef QUARTUS_PATH
	QUARTUS_PATH=""
endif

all:
	$(QUARTUS_PATH)quartus_sh --flow compile de1soc

load:
	$(QUARTUS_PATH)quartus_pgm -a -o "p;build/de1soc.sof"

create_project:
	$(QUARTUS_PATH)quartus_sh -t create_project.tcl

clean:
	rm -rf build/*

run_all: all load