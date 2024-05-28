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

all: build/program.hex

build/program.hex: build/program.bin
	$(HEXDUMP) -v -e '1/4 "%08x\n"' build/program.bin > build/program.hex

build/program.bin: build/program.s
	$(OBJCOPY) -O binary build/program.elf build/program.bin

build/program.s: build/program.elf
	$(OBJDUMP) -d build/program.elf > build/program.s

build/program.elf: build/main.o build/risco5.o
	$(LD) -o build/program.elf build/risco5.o build/main.o -T src/link.ld

build/main.o: main.c
	$(CC) -march=rv32id -std=gnu99 -mabi=ilp32 -Wall -c main.c -o build/main.o \
    -nostartfiles -nostdinc -nostdlib -mstrict-align

build/risco5.o: src/risco5.c
	$(CC) -march=rv32id -std=gnu99 -mabi=ilp32 -Wall -c src/risco5.c -o build/risco5.o \
    -nostartfiles -nostdinc -nostdlib -mstrict-align

clean:
	rm -f build/*.o build/*.elf build/*.bin build/*.hex build/*.s