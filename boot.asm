mov ah, 0x0e
mov al,[variableName]
int 0x10
variableName:
                db "Hello this my first line or sentence to the terminal" , 0
jmp $
times 510-($-$$) db 0
db 0x55, 0xaa
