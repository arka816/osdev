[org 0x7c00]

mov bp, 0x8000          ; set the stack base pointer far enough
mov sp, bp

mov bx, 0x9000          ; [es:bx] = 0x0000:0x9000 = 0x9000 pointer to buffer
mov dh, 2               ; read 2 sectors
; the bios sets 'dl' for our boot disk number

call disk_load

mov dx, [0x9000]        ; retrieve the first loaded word
call print_hex

mov dx, [0x9000 + 512]  ; retrieve the second loaded word
call print_hex

jmp $

%include "../boot-sector-subroutines/boot_sector_print_hex.asm"
%include "../boot-sector-subroutines/boot_sector_print.asm"
%include "disk_read.asm"

times 510-($-$$) db 0
dw 0xaa55

;boot sector = sector 1 of cylinder 0 of head 0 of hdd 0
;sector 2 starts here
times 256 dw 0xabcd     ; sector 2 = 512 bytes
times 256 dw 0x1234     ; sector 3 = 512 bytes