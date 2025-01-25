.intel_syntax noprefix
.globl _start
.section .text

_start:

    # Terminazione del programma
    mov rax, 60           # syscall number per sys_exit (60)
    xor rdi, rdi          # codice di uscita 0
    syscall  