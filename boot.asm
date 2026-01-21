[org 0x7c00]
mov [diskNum], dl    ;# moving the drive number from which we booted from the register dl to pointer diskNum

mov ah, 2            
mov al, 1            ; number of sectors  from which you want to read
mov ch, 0            ; cylinder number from which you want to read
mov cl, 2            ; sector number from  you want to read
mov dh, 0            ; head number from which you want to read
mov dl, [diskNum]    ; the drive number that we saved in the variable or pointer diskNum



push ax              ;pushing ax , so that we can move in zero to it 
mov ax, 0            ; moving in zero or 0 to ax so that we can move zero to ex
mov es, ax           ; moving ax with zero or 0 to es because we can't directly move values to es i guess

                     
                     ;setting up the pointer where we want to load up our sector im memory........
pop ax               ; pointer = es * 16 + bx .....................................................
mov bx, 0x7e00       ;so if we want pointer = 0x7e00
int 0x13             ;we need 'es' to be zero annd 'bx' to be '0x7e00' as the offset 16 bit value
                     ;So then pointer = es (0) * 16 + bx (0x7e00) and pointer becomes 0x7e00
mov ah, 0x0e
mov al, [0x7e00]
int 0x10

jmp $
times 510-($-$$) db 0
db 0x55,0xaa                        ;# Magic booting number at the end of bootsector(512B) 
times 512 db 'A'               ;# writing 'A' in the next 512 bytes

diskNum:                            ; Reversing space for diskNum pointer of 1 byte
     db 0

