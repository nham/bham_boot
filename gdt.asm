gdt_start:

gdt_null:
    dq 0x0

gdt_code:
    ; base = 0x0, limit = 0xfffff
    dw 0xffff    ; Limit bits 0-15
    dw 0x0       ; Base bits 0-15
    db 0x0       ; Base bits 16-23
    db 10011010b ; Present 1, privilege 00, descriptor type 1
                 ; type = 1010
    db 11001111b ; granularity 1, default op. size = 1,
                 ; 64-bit code seg 0, AVL 0
                 ; Limit bits 16-19 = 1111
    db 0x0

gdt_data:
    ; base = 0x0, limit = 0xfffff
    dw 0xffff    ; Limit bits 0-15
    dw 0x0       ; Base bits 0-15
    db 0x0       ; Base bits 16-23
    db 10010010b ; Present 1, privilege 00, descriptor type 1
                 ; type = 1010
    db 11001111b ; granularity 1, default op. size = 1,
                 ; 64-bit code seg 0, AVL 0
                 ; Limit bits 16-19 = 1111
    db 0x0

gdt_end: ; I'm honestly not sure what this does that the label below doesn't do.

gdt_descriptor:
    dw (gdt_end - gdt_start - 1)
    dd gdt_start

CODE_SEG equ (gdt_code - gdt_start)
DATA_SEG equ (gdt_data - gdt_start)
