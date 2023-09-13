bits 32

global mm_module_hw

;mm_module_hw : 
;               -parameters : the contor(int) and the given array(string)
;               -adds to the array the corresponding character
;               -returns the corresponding character from the given_alphabet

mm_module_hw:

    mov edx, [esp + 4] ;contor
    mov eax, [esp + 8]  ;the given array
    add eax, edx ; in eax we have the address of the character that needs to be put in array
    
    ret 8 ;number of bytes that are freed from the stack
    
    
    