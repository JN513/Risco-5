#ifndef __RISCO_5_H__
#define __RISCO_5_H__

#define MEM_SIZE       0x00008004
#define STACK_INIT     MEM_SIZE - 4
#define FRAME_POINTER  0X00004000

#define NOP_TIME 5 // 4 cycles
#define CLK_FREQ 50000000 // 50 MHz
#define MS_TO_CYCLES 50000 // 1MS
#define NUM_NOPS_TO_MS 12500 // 1MS


void *memset (void *dest, register int val, register int len);
void *memcpy (void *out, const void *in, int length);
int strlen(const char *str);
char *strcpy(char *destination, const char *source);
int strcmp(const char *str1, const char *str2);
char *strcat(char *destination, const char *source);

void delay_ms(int time);


#endif // __RISCO_5_H__