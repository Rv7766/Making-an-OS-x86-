mov bp, 0x8000
mov sp, bp
mov ah, 'T'
push ax

mov ah, 'I'
push ax

mov ah, 'M'
push ax

mov ah, 'A'
push ax

pop ax
mov al, ah
mov ah, 0x0e
int 0x10

pop ax
mov al,ah
mov ah, 0x0e
int 0x10

pop ax
mov al, ah
mov ah, 0x0e
int 0x10

pop ax
mov al, ah
mov ah, 0x0e
int 0x10


jmp $
times 510-($-$$) db 0
db 0x55, 0xaa