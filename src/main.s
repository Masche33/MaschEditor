.intel_syntax noprefix
.globl _start
.section .text

_start:


    mov rdi, 100
    call _stdin_read_string

    mov rdi, rax

    call _stdout_print_string

    # Terminazione del programma
    mov rax, 60           # syscall number per sys_exit (60)
    xor rdi, rdi          # codice di uscita 0
    syscall               # chiamata di sistema

.section .data
    message: .asciz "Hello, World!\n"  # Messaggio da stampare
