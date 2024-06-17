.globl _start
.globl strlen
.globl strcpy
.globl strcmp
.globl strcat
.globl memcpy
.globl memset
.extern main

.globl delay_ms

_start:
    li sp, 0x04000;
    li t0, 0x00000000;
    li s0, 0x02000;

    jal main;
    jal exit;

strlen: # int strlen(char *str)
    addi t0, zero, 0
strlen_loop:
    lbu t0, 0(a0)
    beq t1, zero, strlen_end
    addi t0, t0, 1
    addi a0, a0, 1
    j strlen_loop
strlen_end:
    mv a0, t0
    ret

strcpy: # char *strcpy(char *destination, const char *source);
    addi t0, a0, 0
strcpy_loop:
    lbu t1, 0(a1)
    beq t1, zero, strcpy_end
    sb t1, 0(a0)
    addi a0, a0, 1
    addi a1, a1, 1
    j strcpy_loop
strcpy_end:
    sb zero, 0(a0)
    ret


strcmp: # int strcmp(const char *str1, const char *str2);
    lbu t0, 0(a0)
    lbu t1, 0(a1)
    bne t0, t1, strcmp_cmp
    beq t0, zero, strcmp_neg
    beq t1, zero, strcmp_pos
    addi a0, a0, 1
    addi a1, a1, 1
    j strcmp
strcmp_cmp:
    sub a0, t0, t1
    j strcmp_end
strcmp_neg:
    addi a0, zero, -1
    j strcmp_end
strcmp_pos:
    addi a0, zero, 1
strcmp_end:
    ret


strcat: # char strcat(char destination, const char *source)
    addi t0, a0, 0
strcat_loop:
    lbu t1, 0(a0)
    beq t1, zero, strcat_copy
    addi a0, a0, 1
    j strcat_loop
strcat_copy:
    lbu t1, 0(a1)
    sb t2, 0(a0)
    beq t1, zero, strcat_end
    addi a0, a0, 1
    addi a1, a1, 1
    j strcat_copy
strcat_end:
    addi a0, t0, 0
    ret

memcpy: # void *memcpy(void *destination, const void *source, size_t num);
    addi t0, a0, 0
    li t2, 0;
memcpy_loop:
    lw t1, 0(a1)
    sw t1, 0(a0)
    addi t2, t2, 1
    beq t2, a3, memcpy_end
    addi a0, a0, 1
    addi a1, a1, 1
    j memcpy_loop
memcpy_end:
    mv a0, t0
    ret

memset: # void *memset(void *ptr, int value, size_t num);
    addi t0, a0, 0
    li t2, 0;
memset_loop:
    sw a1, 0(a0)
    addi t2, t2, 1
    beq t2, a2, memset_end
    addi a0, a0, 1
    j memset_loop

memset_end:
    mv a0, t0
    ret


delay_ms:
    li t0, 0
    li t1, 4167 # 1ms

delay_loop:
    bge t0, a0, delay_end;
    addi t0, t0, 1;
    li t2, 0;
delay_1ms:
    addi t2, t2, 1;
    bge t2, t1, delay_loop;
    j delay_1ms;
delay_end:
    ret

exit:
    j exit