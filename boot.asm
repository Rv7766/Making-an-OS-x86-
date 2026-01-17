[org 0x7c00]
mov ah, 0x0e
lea bx, variableName

printString:
            mov al,[bx]
            int 0x10
            inc bx
            cmp al, 0
            je exit
            jmp printString

exit:
    jmp $
variableName:
        db "Displaying my first String ", 0



times 510-($-$$) db 0
db 0x55,0xaa 


