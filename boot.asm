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
            mov bx, 0
            jmp InputString


InputString:
            mov ah, 0
            int 0x16
            mov ch,al
            cmp ch, 13
            je reloadbx2
            push cx
            mov ah, 0x0e
            int 0x10

            inc bx
            jmp InputString


reloadbx2:

            jmp printString2

printString2:
            
                pop cx
                mov al, ch
                mov ah, 0x0e
                int 0x10

                cmp bx, 0
                je exit

                dec bx
                jmp printString2


exit:
    jmp $

variableName1:
        db "Input your String in 18 charactors...... ",0


times 510-($-$$) db 0
db 0x55,0xaa 


