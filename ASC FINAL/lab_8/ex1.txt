;Statement 23-th exercise 1: 

;Read a hexadecimal number with 2 digits from the keyboard. 
;Display the number in base 10, in both interpretations: as an unsigned number and as an signed number (on 8 bits).

; declaring extern functions used in the program
extern exit, printf, scanf            
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicating to the assembler that the printf fct can be found in the msvcrt.dll library
import scanf msvcrt.dll      ; similar for scanf

bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit \
is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
        
segment  data use32 class=data ; the data segment where the variables are declared 
        n dd  0       ; defining the variable n
        message  db "n=", 10, 13, 0
        message1 db "the unsigned representation is :",10, 13, 0
        message2 db "the signed representation is :",10, 13, 0
        
		format  db "%x", 0  ; definining the format
        format1 db "%u",10, 13, 0  ;defining the unsigned format
        format2 db "%d", 0  ;defining the signed format 
        
segment  code use32 class=code ; code segment
    start:
            push dword message ; ! on the stack is placed the address of the string, not its value
            call [printf]      ; call function printf for printing
            add esp, 4*1       ; free parameters on the stack; 4 = size of dword; 1 = number of parameters
            
    
            push dword n  ;pushing the parameter on the stack from right to left
            push dword format
            call [scanf]
            add esp, 4 * 2
            
            push dword message1
            call [printf]
            add esp, 4*1
            
            push dword [n]
            push dword format1
            call [printf]
            add esp, 4 * 2
            
            push dword message2
            call [printf]
            add esp, 4 * 1
            
            mov ebx, 256
            mov edx, 0
            mov ecx, [n]
            sub ecx, ebx
            mov [n], ecx
            
            push dword [n]
            push dword format2
            call [printf]
            add esp, 4 * 2
            
            
            
        
    push   dword 0 ;saves on stack the parameter of the function exit
    call   [exit] ; function exit is called in order to end the execution of