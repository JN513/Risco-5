all:
	/mnt/tools/quartus_lite/quartus/bin/quartus_sh --flow compile de1soc

flash:
	/mnt/tools/quartus_lite/quartus/bin/quartus_pgm -a -o "p;build/de1soc.sof"

create_project:
	/mnt/tools/quartus_lite/quartus/bin/quartus_sh -t create_project.tcl

clean:
	rm -rf build/*
