.intel_syntax noprefix
.globl _string_len
.globl _copy_string

.section .text
# Input:
#   - RDI: *char string
# Output:
#   - RAX: Lenght of the inputted string
# Effetcs:
#   returns the lenght of a string
# Requires:
#   A 0x00 terminated string 
_string_len:
         push r9
         push r8
         xor r8, r8
         xor r9, r9

charIteration:
         mov r9b, byte [rdi]
         cmp r9b, 0x00
         je return
         add r8 , 0x01
         add rdi, 0x01
         jmp charIteration

return:
         mov rax, r8
         pop r8
         pop r9
         ret