; al and ah are lower and higher parts of register ax
; 0x0e on ah tells the video interrupt handler that we actually want to write the contents of al in tty mode

mov ah, 0x0e    ; tty mode
mov al, 'H'
int 0x10        ; raise interrupt 0x10 which is a general interrupt for video services
mov al, 'E'
int 0x10
mov al, 'L'
int 0x10
int 0x10
mov al, 'O'
int 0x10

jmp $           ; jump to current address : infinite loop

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55