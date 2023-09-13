; Write a program in the assembly language that computes the following arithmetic expression
; I will solve the 23-th problem from the set of simple exercises firstly
bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
        a dq 1122334455667788h ;EDX:EAX
        b dq 0abcdef1a2b3c4d5eh ;EBX:ECX
segment  code use32 class=code ; code segment
    start: 
        mov EAX, [a]
        mov EDX, [a + 4]
        
        add EAX, [b]
        adc EDX, [b + 4] ; result is the same as in the last 2 lines
        
        mov ECX, [b] ; ECX = 2b3c4d5e
        mov EBX, [b + 4] ; EBX = abcdef1a
        
        add EAX, ECX ; EAX = EAX + ECX and set CF(carry flag) to 0/1
        adc EDX, EBX ; EDX = EDX + EBX + CF
        
        
        
	
	push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of