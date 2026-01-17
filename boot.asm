mov bx, 7
cmp bx, 9
je loop

jmp $

loop:
        mov ah, 0x0e
        mov al, 'X'
        int 0x10


times 510-($-$$) db 0
db 0x55,0xaa 


;#cmp A, B
;#
;#compares A to B,
;#stores the results by 
;#setting "flags" (bit
;#of a certain register)
;#
;#
;# Possible outcomes of the comparision
;#
;#Comparison                  Conditional jump instruction
;#
;#  A == B                                je
;#  A != B                                jne
;#  A  > B                                jg        
;#  A  < B                                jl
;#  A >= B                                jge
;#  A <= B                                jle                     

