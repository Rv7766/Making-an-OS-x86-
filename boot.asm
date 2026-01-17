mov ah, 0x0e
mov al,[variableName + 31744 ]
int 0x10
jmp $
variableName:
        db "Displaying my first String ", 0



times 510-($-$$) db 0
db 0x55,0xaa 


