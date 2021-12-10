mov ah, 0x0e        ; tty mode

; sp : stack pointer -> points to top of stack
; bp : base pointer  -> points to base of stack

mov bp, 0x8000      ; put base pointer far enough for safety
mov sp, bp          ; sp points to bp when stack is empty

push 'A'
push 'B'
push 'C'

; print top of stack
mov al, [0x7ffe]    ; 0x8000 - 2
int 0x10

; only top of stack can be accessed
mov al, [0x8000]
int 0x10

; we can only pop 16 bits
; prints C
pop bx
mov al, bl
int 0x10

; prints B
pop bx
mov al, bl
int 0x10

; prints A
pop bx
mov al, bl
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55
