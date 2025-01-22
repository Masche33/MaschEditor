# MaschEditor

## **Utility**:

### string_core:

In this file there are the core method to manipulate a string

To ensure faster lenght retrieval of a string the user does not have direct acces to the actual string but to a 16B struct(str_pointer).

str_pointer(8B, 8B) stores the lenght of the string in the first 8B and the pointer of the actual string in the other 8B. 

#### _create_string:

- INPUT: 
    - RDI: The size, in char, of the wanted string, (max 2**64-1)
- OUTPUT
    - RAX: The pointer to str_pointer
- EFFECT:
    - Allocates the space on the heap given the size and returns the str_pointer

#### _destroy_string:

- INPUT: 
    - RDI: the str_pointer of the string that has to be destroied
- EFFECT:
    - Free all the memory used for the string

### string_io:

In this file there are the method to read/print strings

#### _stdin_read_string

- INPUT:
    - RDI: The size, in char, of the buffer size
- OUTPUT:
    - RAX: The pointer to str_pointer
- EFFECTS:
    - Reads from stdin a string and returns the str_pointer

#### _stdout_print_string:
- INPUT:
    - RDI: str_pointer
- EFFECTS:
    - Prints the string in stdout