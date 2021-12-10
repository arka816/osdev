disk_load:
    pusha       ; move all general purpose registers to stack
    push dx     ; to store dh

    mov ah, 0x02    ; BIOS read sector function
    mov al, dh      ; al <- how many sectors to read from the first point
    mov cl, 0x02    ; cl <- sector (0x01, ..., 0x11)
                    ; 0x01 is our boot sector, 0x02 is our first available sector
    mov ch, 0x00    ; ch <- cylinder (0x0, ..., 0x3FF)
    mov dh, 0x00    ; dh <- head number (0x0, ..., 0xF)

    ; dl <- drive number. BIOS sets it based on chosen bootable drive in BIOS
    ; (0 : floppy, 1 : floppy2, 0x80 : hdd, 0x81 : hdd2)

    ; [es:bx] <- pointer to buffer where data will be stored
    ; caller sets it up, it is actually the standard location for int 13h

    int 0x13        ; the BIOS interrupt to do the actual read
    jc disk_error   ; if error (stored in the carry bit)

    pop dx
    cmp al, dh      ; post interrupt BIOS sets number of sectors actually read in al
                    ; compare with desired number of sectors set by caller
    jne sector_count_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah      ; ah = error code, dl = disk drive that caused the error
    call print_hex
    jmp hang

sector_count_error:
    mov bx, SECTOR_COUNT_ERROR
    call print
    call print_nl

hang:
    jmp $

DISK_ERROR:
    db "Disk read error", 0

SECTOR_COUNT_ERROR:
    db "Incorrect number of sectors read", 0

