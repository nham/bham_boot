print_string:
    ; we are assuming that the start address of the text to be
    ; printed is in bx.
    xor ax, ax
    mov ds, ax ; ds is used in lodsb, so needs to be cleared. I guess?
    mov si, bx
    mov bx, 0x0

    mov ah, 0x0e
    int 0x10

print_loop:
    lodsb ; AL <-- whatever SI points to, ESI <-- ESI + 1
    cmp al, 0
    je end

    int 0x10
    jmp print_loop

end:
    ret
