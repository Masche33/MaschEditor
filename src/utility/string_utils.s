.intel_syntax noprefix

# INPUT:
#  - RDI: str_pointer
#  - RSI: char to look for
# OUTPUT:
#  - RAX: -1 if the char is not found or the index of it if found
_char_at:
    # GET THE STRING ADDRES
    # GET THE CHAR

    # FOR (i:= 0; i < size; i++)
    # IF(str[i]==CHAR)jmp found

    jmp .notFound
.found:

    ret

.notFound:
    mov rax, -1
    ret