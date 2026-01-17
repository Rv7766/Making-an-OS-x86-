[org 0x7c00]

InputFromKeyboard:
    mov ah, 0                   ;#For inputting
    int 0x16                    ;#For inputting

    mov ah, 0x0e                ;For Displaying
    int 0x10                    ;For Displaying

    
; boot sector
times 510-($-$$) db 0
db 0x55, 0xaa

