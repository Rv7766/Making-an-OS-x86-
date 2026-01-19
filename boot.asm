[org 0x7c00]
mov ah, 0x0e
lea bx, variableName1
jmp printString

printString:
            mov al,[bx]
            int 0x10
            inc bx
            cmp al, 0
            je reloadbx
            jmp printString

reloadbx:
            lea bx,buffer
            jmp InputString


InputString:
            mov ah, 0
            int 0x16
            mov [bx],al
            mov ah, 0x0e
            int 0x10

            inc bx
            cmp al, 13
            je reloadbx2
            jmp InputString


reloadbx2:
            mov bx,buffer
            mov ah, 0x0e
            mov al, 13
            int 0x10

            jmp printString2

printString2:
            mov al,[bx]
            int 0x10
            cmp al, 0
            je exit
            inc bx
            jmp printString2


exit:
    mov al, buffer
    jmp $

variableName1:
        db "Input your String in 18 charactors...... ",0

buffer:
    times 18 db 0

times 510-($-$$) db 0
db 0x55,0xaa 


