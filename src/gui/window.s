.intel_syntax noprefix
    .section .data
display_name:
    .byte 0           # Display name (NULL per il default)
window_width:
    .long 400         # Larghezza della finestra
window_height:
    .long 400         # Altezza della finestra
window_title:
    .asciz "Finestra 400x400"   # Titolo della finestra

    .section .bss
display:
    .skip 8           # riserva 8 byte (per un puntatore a display)
window:
    .skip 8           # riserva 8 byte (per un puntatore alla finestra)
event:
    .skip 8           # riserva 8 byte (per un puntatore all'evento)

    .section .text
    .global _start

_start:
    # Apri la connessione al server X
    lea rdi, [display_name]      # Passiamo NULL (display_name) a XOpenDisplay
    call XOpenDisplay
    mov [display], rax           # Salviamo il valore di ritorno (display)

    # Crea una finestra
    mov rdi, [display]           # Carica il valore di display
    call XDefaultRootWindow      # Otteniamo la finestra radice
    mov rdi, rax                 # Finestra radice
    mov rsi, 0                   # Colore di background (0 = bianco)
    mov rdx, [window_width]      # Larghezza
    mov rcx, [window_height]     # Altezza
    mov r8, 0                    # X Position
    mov r9, 0                    # Y Position
    call XCreateSimpleWindow     # Crea la finestra

    # Imposta il titolo della finestra
    lea rdi, [display]           # Carica indirizzo di display
    lea rsi, [window]            # Carica indirizzo di window
    lea rdx, [window_title]      # Carica indirizzo di window_title
    call XStoreName

    # Mappa la finestra (la rende visibile)
    lea rdi, [display]           # Carica indirizzo di display
    lea rsi, [window]            # Carica indirizzo di window
    call XMapWindow

    # Gestisce gli eventi
.event_loop:
    lea rdi, [display]           # Carica indirizzo di display
    lea rsi, [event]             # Carica indirizzo di event
    call XNextEvent              # Attende e riceve un evento
    cmp rax, 0                   # Se l'evento è di tipo 'destroy'
    je .exit                     # Esce dal ciclo se si chiude la finestra
    jmp .event_loop

.exit:
    # Distruggi la finestra e chiudi la connessione
    lea rdi, [display]           # Carica indirizzo di display
    lea rsi, [window]            # Carica indirizzo di window
    call XDestroyWindow

    lea rdi, [display]           # Carica indirizzo di display
    call XCloseDisplay

    # Termina il programma
    mov rax, 60                  # codice di uscita (exit)
    xor rdi, rdi                 # codice di ritorno (0)
    syscall

# Funzioni X11 chiamate tramite syscall
XOpenDisplay:
    mov rax, 0x6C
    syscall
    ret

XCreateSimpleWindow:
    mov rax, 0x15
    syscall
    ret

XDefaultRootWindow:
    mov rax, 0x1C
    syscall
    ret

XStoreName:
    mov rax, 0x4D
    syscall
    ret

XMapWindow:
    mov rax, 0x16
    syscall
    ret

XNextEvent:
    mov rax, 0x19
    syscall
    ret

XDestroyWindow:
    mov rax, 0x18
    syscall
    ret

XCloseDisplay:
    mov rax, 0x2C
    syscall
    ret

