.intel_syntax noprefix
.globl _stdin_read_string
.globl _stdout_print_string

.section .text

# INPUT:
# - RDI: Buffer size
# OUTPUT:
# - RAX: The pointer of str_pointer
# EFFECTS:
#  Read a string from stdin
_stdin_read_string:
    mov r8, rdi 

    # READ
    sub rsp, r8
    mov rdx, rdi
    mov rsi, rsp
    mov rdi, 0
    mov rax, 0
    syscall

    # ALLOCATE SPACE
    mov rdi, rax
    call _create_string

    # In rax = str_pointer
    mov r9, [rax]
    mov r11, [rax+8]
    xor r10, r10

charcopy:
    mov r12, [rsp+r10]
    mov [r11+r10], r12
    inc r10
    cmp r10, r9
    jle charcopy

    # RETURN

    add rsp, r8
    ret

# INPUT:
# - RDI: str_pointer
# EFFECTS:
# - Prints the string in stdout
_stdout_print_string:
    mov r8, [rdi]
    mov r9, [rdi+8]

    mov rsi, r9
    mov rdx, r8
    mov rdi, 1
    mov rax, 1
    syscall

    ret