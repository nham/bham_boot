[org 0x7c00]
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl ; BIOS stores boot drive in DL

    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call load_kernel ; put kernel in memory

    call switch_to_pm

    jmp $ ; jump to this line over and over

%include "print_string.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string

    ; prep for disk_load
    mov bx, KERNEL_OFFSET ; where in memory we are loading the kernel
    mov dh, 1 ; number of sectors
    mov dl, [BOOT_DRIVE] ; letter of the drive? TODO
    call disk_load

    ret

[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    call KERNEL_OFFSET

    jmp $ ; jump to this line over and over

BOOT_DRIVE db 0
MSG_REAL_MODE db "Keeping it real.", 0
MSG_PROT_MODE db "Made it to protected mode. lalalalala", 0
MSG_LOAD_KERNEL db "Loading kernel nowwww...", 0

; bootsector padding + adding the boot signature
times 510-($-$$) db 0
dw 0xaa55
