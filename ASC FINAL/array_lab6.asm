bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
        s1 db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
        lens1 equ $-s1 ;the lenght of the array
        two db 2
        sum db 0
segment  code use32 class=code ; code segment
    start: 
        ;sum of even elements (bytes) in s1
        
        mov bl, 0 ;compute the sum here
        mov ecx, lens1 ;the lenght of the array is put into ecx which is decremented at each step
        mov esi, 0 ;source -> this is the index
        jecxz skip_loop
        sum_loop:
            mov al, [s1 + esi] ;s1[esi]
            mov ah, 0 ;al->ax (unsigned conversion)
            div byte [two] ; al = ax / 2 , ah = ax % 2
            cmp ah, 0
            jne donotadd
                add bl, [s1 + esi]
                jmp over_oddnumbers
            donotadd:
                add bh, [s1 + esi]
            over_oddnumbers:
            inc esi
        loop sum_loop
        skip_loop:
        
        mov [sum], bl
        
        ;exit(0)
	
	push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of