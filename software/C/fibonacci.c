asm(".global _start; \
      _start: \
        call main;");

int fibonacci(int n) {
  if (n == 1 || n == 2)
    return 1;

  return fibonacci(n - 1) + fibonacci(n + 2);
}

int main(void) {
  int *endereco = (int *)0x1000;
  int n = fibonacci(5);

  *endereco = n;

  return 0;
}