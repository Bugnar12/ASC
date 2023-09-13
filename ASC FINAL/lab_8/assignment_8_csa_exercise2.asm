;Statement 23-th exercise2: 
;A file name and a hexadecimal number are given. 
;Create a file with the given name and write each nibble composing the hexadecimal number on a different line to file.

; declaring extern functions used in the program
extern exit, fopen, fprintf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit \
is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
        
segment  data use32 class=data ; the data segment where the variables are declared 

    file_name db "hexa.txt", 0 ;filename
    access_mode db "w", 0
    format  db "%x", 10, 0 ; definining the format
    
    file_des1 dd -1
    n dd 0abdh          ;hexadecimal number to be read from the file
    message db "The hexadecimal number is : ", 0
    message1 db "The nibbles of the hex-number are :", 10
    hex db 16
    
    n1 resd 1
    n2 resb 1
    


segment  code use32 class=code ; code segment
    start:
        ;first we read the hexadecimal number in the fila
        
        ;calling fopen to create the file and emptying the stack
        push dword access_mode     
        push dword file_name
        call [fopen]
        add esp, 4*2 

        mov [file_des1], eax  ; store the file descriptor returned by fopen   
        
        cmp eax, 0
        je no_digits
        
        push dword message
        push dword [file_des1]
        call [fprintf]
        add esp, 4 * 2
        
        ;fprintf(file_des1, text)
        push dword [n]
        push dword format
        push dword [file_des1]
        call [fprintf]
        add esp, 4 * 3
        
        
        mov ax, [n]
        
        ;in n we have the hexadecimal number
        repeta:
            mov cl, 16
            div cl ;al -> quotient(A) ; ah -> remainder(B)
            
            ;we want to display ONLY the REMAINDERS
            
            mov [n1], ah ;in n1 we have the remainder stored
            mov [n2], al ;registers modify after prints
            
            push dword [n1]
            push dword format
            push dword [file_des1]
            call [fprintf]
            add esp, 4 * 3 ;we write in the .txt
            
            ;check if the hexadecimal number still has digits
            
            mov al, [n2]
            mov ah, 0 ; ax <- quotient
            mov dx, 0
            push dx
            push ax
            pop eax
            
            
            cmp eax, 0
            jle no_digits
            
            ;go to the next digit 
            mov ah, 0
            
            
        loop repeta
          
        
        
        no_digits:
            ; fclose(file_descriptor)
            push dword [file_des1]
            call [fclose]
            add esp, 4
   
    
    
    push   dword 0 ;saves on stack the parameter of the function exit
    call   [exit] ; function exit is called in order to end the execution of