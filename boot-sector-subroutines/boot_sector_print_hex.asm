print_hex:
    pusha               ; move all general purpose registers to stack
    mov cx, 0           ; loop counter


; numeric ASCII values: '0' (ASCII 0x30) to '9' (0x39), so just add 0x30
; for alphabetic characters A-F: 'A' (ASCII 0x41) to 'F' (ASCII 0x46)
hex_loop:
    ; loop 4 times
    cmp cx, 4
    je end

    ; convert last character of dx to ascii
    mov ax, dx
    and ax, 0x000f      ; 0x1234 -> 0x0004
    add al, 0x30        ; 0x04 -> 0x34
    cmp al, 0x39        ; compare to check if ascii code is greater than 9
    jle step_2
    add al, 7           ; 'A' is ASCII 65 (0x41) instead of 58 (0x 3A)

step_2:
    mov bx, HEX_OUT + 5 ; move pointer to end of string
    sub bx, cx          ; bx <- base address + length - current index of char
    mov [bx], al
    ror dx, 4           ; 0x1234 -> 0x0123

    add cx, 1           ; increase counter
    jmp hex_loop

end:
    mov bx, HEX_OUT     ; HEX_OUT is the address to be printed
    call print
    call print_nl
    
    popa                ; restore original register values
    ret

; reserve memory for our new string
HEX_OUT:
    db '0x0000', 0
