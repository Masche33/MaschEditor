.intel_syntax noprefix
.globl _char_at
.section .text


# INPUT:
#- RDI: str_pointer
#- RSI: char to look for
# OUTPUT:
#- RAX: -1 if the char is not found or the index of it if found
_char_at:
  # GET THE STRING ADDRES
  
  mov r8, [rdi]   # String size
  mov r9, [rdi+8] # String pointer
  
  xor r11, r11
  xor r10, r10
.getChar:
  mov r11b, byte [r9]
  cmp r11b, sil
  je .found
  inc r9
  inc r10
  cmp r10, r8
  jl .getChar
  jmp .notFound
.found:
  mov rax, r10
  ret
.notFound:
  mov rax, -1
  ret
