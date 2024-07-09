# Getting Started with Risco-5

## Tests / Simulation

The "tests" directory contains some tests for the project modules. These tests were developed to be used with [Iverilog](https://steveicarus.github.io/iverilog/). To run the tests, simply use Iverilog and VVP as shown in the example below:

```bash
iverilog -o build/core_test.o -s core_tb src/core/* src/peripheral/memory.v tests/core_test.v
vvp build/core_test.o
```

To facilitate running the tests, you can use the "run_test" script available at the root of the project. When running this script, it will prompt for the name of the test and the name of one of the assembly test files available in the "software/code/" directory. As a result, a "soc.vcd" file will be generated in "build/" which can be analyzed using GTKWave.

### Requirements:

- Iverilog
- GTKWave

These dependencies can be obtained through the [oss cad suite](https://github.com/YosysHQ/oss-cad-suite-build) or can be installed individually.

## FPGA

The project supports testing on several FPGAs, listed below:

- Colorlight i9 - ECP5 45F
- Digilent Arty A7 100t
- Digilent Nexys 4 DDR
- Tangnano 20k
- AMD/Xilinx VC709 Connectivity Kit

Examples are available in the "FPGA" directory. For Sipeed FPGAs (Tangnano 9k and 20k), the examples were developed using the Gowin IDE. For Lattice/ColorLight FPGAs, the examples were developed using Yosys + NextPNR and can be synthesized and programmed using the makefile available in the directories. For Xilinx FPGAs, Vivado was used, and the examples can also be utilized using the makefile available in the directory.

### Requirements

- AMD/Xilinx:
    - Vivado
    - openFPGALoader
- Lattice/Colorlight:
    - Yosys
    - Nextpnr-ECP5
    - ecppack
    - openFPGALoader
- Gowin/Sipeed:
    - Gowin EDA
    - openFPGALoader

- General:
    - Pyserial or VSCode Serial or Minicom or other software capable of using serial

### Running the Test on FPGA

Navigate to the "fpga/???" directory, with "???" being the name of the FPGA to be used, and run the command "make". This will perform the project synthesis. To load the bitstream onto the board, use "make flash". If you want to do everything at once, use "make run_all".

#### FPGA Feedback

If everything goes well, the FPGA LEDs will start blinking in a counting rhythm, and an ASCII character will begin to be sent over the serial connection. The serial operates at a standard baud rate of 115200 bps.