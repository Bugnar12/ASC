;Read a string s1 (which contains only lowercase letters). 
;Using an alphabet (defined in the data segment), determine and display the string s2
;obtained by substitution of each letter of the string s1 with the corresponding letter in the given alphabet.
;Example:
;The alphabet(given):  OPQRSTUVWXYZABCDEFGHIJKLMN
;The alphabet(normal): abcdefghijklmnopqrstuvwxyz
;The string s1: anaaremere
;The string s2: OBOOFSASFS

;summary : parse the given array character by character, search into the normal alphabet
;the POSITION on which the character is, afterwards look in the given array on what position
;that character would be and extract it to the output array

bits 32
global start

extern printf, exit, scanf
import printf msvcrt.dll
import exit msvcrt.dll
import scanf msvcrt.dll

extern mm_module_hw

segment data use32 class=data

    given_array times 100 db 0
    normal_alphabet db 'abcdefghijklmnopqrstuvwxyz'
    given_alphabet db 'OPQRSTUVWXYZABCDEFGHIJKLMN'
    output_array times 100 db 0
    contor resb 1
    rez dd 0
    format1 db "%s", 0
    format_string db "The transformed array is: %s", 0
    format2 db "%d", 0
    
segment code use32 class=code
     
start:
    ;the given_array that is read
    push dword given_array
    push dword format1
    call [scanf]
    add esp, 4 * 2
   
    
    ;compute the length of the array
    mov ecx, 0
    mov ebx, given_array
    length1:
        cmp byte [ebx], 0
        je finish
        inc ebx
        inc ecx
        jmp length1
    finish:
    ;in ecx we have the length of the array
    
    mov ebp, 0
    mov esi, given_array
    mov edi, output_array
    cld
    loop1:
        lodsb ;in al is the corresponding character , al <- character from the given array
        mov ebp, normal_alphabet
        mov byte [contor], 0 ;this represents the position on which we will find the character
        
        loop2: ;here we parse the normal_alphabet
            mov bl, [ebp]
            inc ebp
            cmp al, bl ;we compare the characters
            je add_array ;if we find the character in the array we jump to the add_array label
            inc byte [contor]
            jmp loop2
        
        add_array: ;here we look in the second given alphabet for the letter and transfer it into the final array
            mov edx, given_alphabet
            
            push dword edx
            push dword [contor] ;push the parameters used in the module

            call mm_module_hw ;call the module
            
            mov edx, eax ;move the result given from the module to edx
            
            mov al, [edx]
            stosb ;store the letter into the output_array
            
    loop loop1
    
    mov dword [contor], 0
    
    push output_array       
    push format_string
    call [printf]
    add esp, 2 * 4
        

    push 0
    call [exit]