[org 0x7c00]

mov bp, 0x9000
mov sp, bp
mov bx, MSG_REAL_MODE
call print_string

call switch_to_pm

jmp $ ; jump to this line over and over

%include "print_string.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $ ; jump to this line over and over

MSG_REAL_MODE db "In real mode for now", 0
MSG_PROT_MODE db "Made it to protected mode. lalalalala", 0

; bootsector padding + adding the boot signature
times 510-($-$$) db 0
dw 0xaa55
