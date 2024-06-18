OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY{
    RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 0x08000
}
SECTIONS {
    . = 0x00000000;
    .text : { *(.text) } > RAM
    . = ALIGN (2);
    .data : { *(.data) } > RAM
    .bss  : { *(.bss)  } > RAM
    .heap : { *(.heap) } > RAM
    .stack : { *(.stack) } > RAM
}