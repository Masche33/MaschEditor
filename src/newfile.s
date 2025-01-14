.intel_syntax noprefix
.globl _create_file

.section .text
# Input:
#   - RDI: *char file_path
# Effetcs:
#   creates the file in the path given
# Requires:
#   A string
_create_file:
    push rax
    push rsi
    push rdi
    push rdx
    # Open
    mov rax, 2
    # rdi was there
    mov rsi, 577
    mov rdx, 0644
    syscall

    # Close
    mov rdi, rax
    mov rax, 3
    syscall

    pop rdx
    pop rdi
    pop rsi
    pop rax

    ret