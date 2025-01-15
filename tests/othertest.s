.intel_syntax noprefix
.globl _start
.section .text

_start:
    mov rax, 0            # syscall number per sys_read (0)
    mov rdi, 0            # file descriptor 0 (stdin)
    lea rsi, [rip+input]        # indirizzo del buffer di input
    mov rdx, 100          # massimo numero di byte da leggere
    syscall               # chiamata di sistema

    mov rdx, rax          # lunghezza dell'input (ritorna in rax dopo sys_read)
    mov rax, 1            # syscall number per sys_write (1)
    mov rdi, 1            # file descriptor 1 (stdout)
    lea rsi, [rip+input]        # indirizzo del buffer di input
    syscall               # chiamata di sistema

    mov rax, 60           # syscall number per sys_exit (60)
    xor rdi, rdi          # codice di uscita 0
    syscall               # chiamata di sistema

.section .data
    input: .byte 100        # Riserva 100 byte per l'input