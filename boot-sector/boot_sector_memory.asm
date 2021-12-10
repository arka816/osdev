; [org 0x7c00] global offset offsets all referenced memory addresses
mov ah, 0x0e        ; tty mode

; Attempt 1
; tries to print the memory address (i.e. pointer)
mov al, '1'
int 0x10
mov al, secret
int 0x10

; Attempt 2
; tries to access the value at the memory address
; but the actual address is offset by 0x7c00 since that's where the boot sector is stored at boot time
mov al, '2'
int 0x10
mov al, [secret]
int 0x10

; Attempt 3
; Add the Boot sector starting offset 0x7c00
mov al, '3'
int 0x10
mov bx, secret
add bx, 0x7c00
mov al, [bx]
int 0x10


jmp $               ; infinite loop

secret:
    db 'X'

; padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55
