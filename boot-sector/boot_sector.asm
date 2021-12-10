; infinite loop (eb fe) eb: fe - 80 for jump backward
; e9  = jump near instruction in x86
; x86 uses little endian byte order
loop:
    jmp loop

; fill with 510 minus the size of the previous code
; $ : the current address of the statement
; $$ : the address of the beginning of the current section
; times is an assembler specific command, has nothing to do with x86 instruction set
; db = define byte size (8 bits)
; db 510-($-$$) DUP(0) : unknown operand DUP to nasm
times 510-($-$$) db 0
; Magic Number
; dw = define word size (16 bits)
; to make sure disk is bootable bootloader checks whether the 511-th and 512-th of the boot sector are 0xaa and 0x55 respectively
dw 0xaa55
