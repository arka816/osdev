; subroutine for printing

print:
    pusha           ; push all general purpose registers to stack

start:
    mov al, [bx]
    cmp al, 0
    je done

    mov ah, 0x0e
    int 0x10

    add bx, 1
    jmp start

done:
    popa            ; restore original register values
    ret


; subroutine for printing newline character

print_nl:
    pusha           ; push all general purpose registers to stack

    mov ah, 0x0e
    mov al, 0x0a    ; newline character
    int 0x10
    mov al, 0x0d    ; carriage return
    int 0x10

    popa            ; restore original register values
    ret

; jmp $