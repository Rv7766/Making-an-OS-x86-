mov ah, 0x0e
mov al, 90
jmp loop

loop:
        int 0x10
        dec al                                                          
        cmp al, 'A' - 1                                                   ;#Exiting the loop in assembly:  
        je exit                                                           ;#    cmp al, 'Z' + 1
        jmp loop                                                          ;#    je  exit

exit:

    jmp $


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

