OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY{
    RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 0x02000
}
SECTIONS {
    . = 0x00000000;
    .text : { *(.text) } > RAM
    . = ALIGN (4);
    .data : { *(.data) } > RAM
}