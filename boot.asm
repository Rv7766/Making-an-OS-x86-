[org 0x7c00]                    ; Tell assembler code will be loaded at 0x7c00 (bootloader address)

start:
    ; === SWITCH TO PROTECTED MODE ===
    
    cli                         ; Clear interrupts - disable interrupts during mode switch
    lgdt [GDT_Descriptor]       ; Load the Global Descriptor Table into the CPU
    
    ; Enable protected mode by setting bit 0 of CR0 register
    mov eax, cr0                ; Read current CR0 value into EAX
    or eax, 1                   ; Set the PE (Protection Enable) bit (bit 0)
    mov cr0, eax                ; Write modified value back to CR0
    
    ; Perform far jump to flush CPU pipeline and load code segment
    jmp CODE_SEG:start_protected_mode

; === GLOBAL DESCRIPTOR TABLE (GDT) ===
; Defines memory segments for protected mode

GDT_Start:
    ; Null descriptor (required - must be first entry)
    null_descriptor:
        dd 0                    ; 4 bytes of zeros
        dd 0                    ; 4 bytes of zeros
    
    ; Code segment descriptor
    code_descriptor:
        dw 0xffff               ; Segment limit (bits 0-15) - max segment size
        dw 0                    ; Base address (bits 0-15) - segment starts at 0
        db 0                    ; Base address (bits 16-23)
        db 0b10011010           ; Access byte:  
                                ;   Present=1, Privilege=00, Type=1 (code/data)
                                ;   Executable=1, Direction=0, Readable=1, Accessed=0
        db 0b11001111           ; Flags (4 bits) + Limit (bits 16-19):
                                ;   Granularity=1 (4KB blocks), Size=1 (32-bit), Limit=1111
        db 0                    ; Base address (bits 24-31)
        
    ; Data segment descriptor
    data_descriptor:
        dw 0xffff               ; Segment limit (bits 0-15)
        dw 0                    ; Base address (bits 0-15)
        db 0                    ; Base address (bits 16-23)
        db 0b10010010           ; Access byte:
                                ;   Present=1, Privilege=00, Type=1
                                ;   Executable=0, Direction=0, Writable=1, Accessed=0
        db 0b11001111           ; Flags + Limit (same as code segment)
        db 0                    ; Base address (bits 24-31)
        
GDT_End:

; GDT Descriptor structure - tells CPU where GDT is located
GDT_Descriptor:
    dw GDT_End - GDT_Start - 1  ; Size of GDT minus 1
    dd GDT_Start                ; Starting address of GDT

; Calculate segment selector offsets
CODE_SEG equ code_descriptor - GDT_Start    ; Code segment selector = 0x08
DATA_SEG equ data_descriptor - GDT_Start    ; Data segment selector = 0x10

; === PROTECTED MODE CODE (32-bit) ===

[bits 32]                       ; Assemble as 32-bit code from here

start_protected_mode:
    ; Set up segment registers for protected mode
    ; (Note: Original code missing this - should set DS, ES, SS, etc. to DATA_SEG)
    
    ; Write a character to VGA text mode memory
    mov al, 'A'                 ; Character to display: 'A'
    mov ah, 0x04                ; Attribute byte: 0x04 = red on black
    mov [0xb8000], ax           ; Write to VGA text buffer (top-left corner)
    
    ; Halt the system
    jmp $                       ; Infinite loop - jump to current address

; === BOOT SECTOR SIGNATURE ===

times 510-($-$$) db 0           ; Pad with zeros to byte 510
                                ; $ = current address, $$ = section start
dw 0xaa55                       ; Boot signature (bytes 511-512)
                                ; BIOS checks for this to validate bootloader