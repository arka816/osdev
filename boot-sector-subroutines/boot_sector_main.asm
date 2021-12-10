[org 0x7c00]        ; global offset

mov bx, HELLO
call print
call print_nl

mov bx, GOODBYE
call print
call print_nl

mov dx, 0x12fe
call print_hex

; Data
HELLO:
    db 'HOLA', 0

GOODBYE:
    db 'DOSVIDANYA', 0

jmp $

%include "boot_sector_print.asm"    ; this gets simply replaced by the contents of the file (assembler directive)
%include "boot_sector_print_hex.asm"

times 510-($-$$) db 0
dw 0xaa55