[org 0x7c00]
start:
    ; Set up segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00

    ; Load GDT and switch to protected mode
    cli
    lgdt [GDT_Descriptor]
    
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    
    jmp CODE_SEG:start_protected_mode

GDT_Start:
    null_descriptor:
        dd 0
        dd 0
    
    code_descriptor:
        dw 0xffff
        dw 0
        db 0
        db 0b10011010
        db 0b11001111
        db 0
        
    data_descriptor:
        dw 0xffff
        dw 0
        db 0
        db 0b10010010
        db 0b11001111
        db 0
        
GDT_End:

GDT_Descriptor:
    dw GDT_End - GDT_Start - 1
    dd GDT_Start

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start

[bits 32]
start_protected_mode:
    ; Set up segment registers
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    ; Write to video memory
    mov al, 'A'
    mov ah, 0x0f
    mov [0xb8000], ax
    
    ; Halt
    jmp $

; Boot sector padding and signature
times 510-($-$$) db 0
dw 0xaa55