[org 0x7c00]

mov ah, 0x0e
mov bx, helloworld
jmp printout

printout:
    mov al, [bx]

    cmp al, 0x0
    je exit

    int 0x10
    inc bx

    jmp printout

exit:
    jmp $

helloworld:
    db "Input What You Want to Input to the Screen.....", 0x0

; boot sector
times 510-($-$$) db 0
db 0x55, 0xaa