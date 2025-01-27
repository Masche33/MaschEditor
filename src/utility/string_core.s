.intel_syntax noprefix
.globl _create_string
.globl _destroy_string

# str_pointer:
# 64 bit: Size
# 64 bit: Point to the actual string

# INPUT:
# - RDI: Size
# OUTPUT
# - RAX: str_pointer
# EFFECT:
# Allocates the space for the string in the heap
_create_string:
  # PRESERVING IMPORTANT REGISTER

  push r8
  push rsi
  push rdx
  push rdi      # PUSH SIZE OF STRING

  mov rax, 9    # SYSCALL CODE (MMAP)
  xor rdi, rdi  # ADDRES CHOSEN BY KERNEL
  mov rsi, 16   # 128 bit of the struct
  mov rdx, 3    # W/R permission
  mov r10, 0x22 # General purpose
  xor r8, r8    # null FD
  xor r9, r9    # null Offset
  syscall


  # IN RAX I GOT AN INDEX
  mov r11, rax # In r11 there is the index of the struct()
  pop r8       # In r8 i got the size of the string
  mov [r11], r8
  push r11

  mov rax, 9    # SYSCALL CODE (MMAP)
  xor rdi, rdi  # ADDRES CHOSEN BY KERNEL
  mov rsi, r8   # Size of the struct
  mov rdx, 3    # W/R permission
  mov r10, 0x22 # General purpose
  xor r8, r8    # null FD
  xor r9, r9    # null Offset
  syscall

  test rax, rax  # Did the syscall fail 
  js .mmapFailed  # Handling fail

  pop r11        
  mov [r11+8], rax

  # Restoring register
  pop rdx
  pop rsi
  pop r8
  mov rax, r11 # Ret the struct

  ret

.mmapFailed:
  mov rax, 60     
  mov rdi, -1     
  syscall



# INPUT:
# - RDI: str_pointer
# OUTPUT
# Frees the memory
_destroy_string:

  # Preserving register
  push rsi
  push rdi
  mov r8, [rdi]    # Size 
  mov r9, [rdi+8]  # Addres

  mov rax, 11
  mov rdi, r9
  mov rsi, r8
  syscall

  mov rax, 11
  pop rdi
  mov rsi, 16
  syscall

  # Restore register
  pop rsi
  ret
