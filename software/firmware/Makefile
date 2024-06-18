# header file path: ./lib/risco5.h
# src file path: ./src/risco5.c
# main file path: ./main.c
# makefile path: ./Makefile

# make order: .C -> .S -> .o -> .elf -> .bin -> .hex

# makefile
# 1. define the compiler and the flags
# 2. define the source files
# 3. define the object files
# 4. define the target file
# 5. define the rules to make the target file

COMPILER=riscv32-unknown-elf-

CC=$(COMPILER)gcc
AS=$(COMPILER)as
LD=$(COMPILER)ld
OBJCOPY=$(COMPILER)objcopy
HEXDUMP=hexdump
OBJDUMP=$(COMPILER)objdump
MARCH=rv32imzicsr

all: build/program.hex

build/program.hex: build/program.bin buildFolder
	$(HEXDUMP) -v -e '1/4 "%08x\n"' build/program.bin > build/program.hex

build/program.bin: build/program.s
	$(OBJCOPY) -O binary build/program.elf build/program.bin

build/program.s: build/program.elf
	$(OBJDUMP) -d build/program.elf > build/program.s

build/program.elf: build/main.o build/risco5_lib.o build/uart.o build/gpio.o build/conversion.o build/pwm.o
	$(LD) -o build/program.elf build/risco5_lib.o build/uart.o build/gpio.o build/conversion.o build/pwm.o build/main.o -T utils/link.ld

build/main.o: main.c
	$(CC) -march=$(MARCH) -mabi=ilp32 -Wall -c main.c -o build/main.o \
    -nostartfiles -nostdinc -nostdlib -mstrict-align

build/pwm.o: src/pwm.c
	$(CC) -march=$(MARCH) -mabi=ilp32 -Wall -c src/pwm.c -o build/pwm.o \
    -nostartfiles -nostdinc -nostdlib -mstrict-align

build/risco5_lib.o: src/risco5_lib.s
	$(AS) -march=$(MARCH) -mabi=ilp32 src/risco5_lib.s -o build/risco5_lib.o

build/uart.o: src/uart.s
	$(AS) -march=$(MARCH) -mabi=ilp32 src/uart.s -o build/uart.o

build/gpio.o: src/gpio.s
	$(AS) -march=$(MARCH) -mabi=ilp32 src/gpio.s -o build/gpio.o

build/conversion.o: src/conversion.s
	$(AS) -march=$(MARCH) -mabi=ilp32 src/conversion.s -o build/conversion.o

buildFolder:
	mkdir -p build

clean:
	rm -f build/*.o build/*.elf build/*.bin build/*.hex build/*.s
