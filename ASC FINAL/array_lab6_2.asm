bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit, printf, scanf ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf
segment  data use32 class=data ; the data segment where the variables are declared 
    format db "%d", 0 ;decimal unsigned numbers
    message db "Array is:", 0
    sir dd 0
segment  code use32 class=code ; code segment
    start: 
        push dword message ; ! on the stack is placed the address of the string, not its value
        call [printf]      ; call function printf for printing
        add esp, 4*1
    
        push dword sir       ; ! addressa of n, not value
        push dword format
        call [scanf]       ; call function scanf for reading
        add esp, 4 * 2
        
        
    
	
	push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of