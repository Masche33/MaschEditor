.intel_syntax noprefix
.globl _string_lenght
.globl _copy_string

.section .text
# Input:
#   - RAX: *char string
# Output:
#   - RAX: Lenght of the inputted string
# Effetcs:
#   returns the lenght of a string
# Requires:
#   A string 
_string_lenght:
    push rsi
    push rdi
    push r8
    mov rsi, rax

    # mov rdi, rdi; implicit
    xor rax, rax
    xor r8, r8
    iter_char:
        mov al, [rsi] # Read the char
        cmp al, 0x00  # is it 0x00
        je return # if not go on 
        add r8, 1     # r8++
        add rsi, 1    # rdi++
        jmp iter_char
    return:
    mov rax, r8
    pop r8
    pop rdi
    pop rsi
    
    ret

# Input:
#   - RAX: *char string
# Output:
#   - RAX: A new *char string_copy
# Effetcs:
#   Create a copy of a string
# Requires:
#   A string 
_copy_string:
    