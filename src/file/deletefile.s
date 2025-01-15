.intel_syntax noprefix
.globl _delete_file
.section .text
# Input:
#   - RDI: *char file_path
# Effetcs:
#   if the file is found it delets it
# Requires:
#   A string
_delete_file:
    push rax
    mov rax, 87
    syscall
    pop rax
    ret