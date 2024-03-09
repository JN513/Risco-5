__asm__(".global _start;"
        "_start:"
        "	li sp, 0;"
        "	li a1, 5;"
        "	call main;");

int main() {
    int a = 2;
    int b = 3;
    int c = a + b;

    return 0;
}