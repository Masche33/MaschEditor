.intel_syntax noprefix
.globl _string_to_int
.globl _int_to_string


# INPUT:
# - RDI: str_pointer, that has represent a positive number under 2^64-1
# OUTPUT:
# - RAX: The integer
_string_to_int:
  
  mov r8, [rdi]
  mov r9, [rdi+8]

  dec r8

  xor r10, r10 # In r10 there is the result
  xor r11, r11 # The counter
.digits:
  # GET THE DIGIT
  mov r12b, [r9]

  cmp r12b, 48
  jl .error
  cmp r12b, 57
  jg .error


  # MUL RES BY 10
  mov rax, 10
  mul r10
  mov r10, rax

  # r12b - 48
  mov r13, 48
  sub r12, r13
  add r10, r12

  inc r9
  inc r11

  cmp r11, r8
  jl .digits

  mov rax, r10
  ret
.error:
  mov rax, -1
  ret

# INPUT
# - RDI: An integer
# OUTPUT:
# - RAX: str_pointer to a string equivalent to RDI
_int_to_string:
  # RES = 0
  # buffer = RDI % 10
  # buffer += 48
  # push buffer
  # rdi /= 10
  # (Do it while RDI != 0)
.dividing 



  # CREATE STRING
  # RETURN 
  ret
