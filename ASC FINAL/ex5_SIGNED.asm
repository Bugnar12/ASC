;a - dw ; b, d - byte ; c - w; e - qw
;a + b / c - d * 2 - e

bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 

extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 
        ;SIGNED
		a dd 125
		b db -1
		c dw 12
		d db 2
		e dq 80
segment  code use32 class=code ; code segment
    start: 
		;a + b / c - d * 2 - e = 125+10-4-80=51
		;b / c
		mov AL, [b] ; AL -> DX : AX
		cbw        ;AL -> AX
        cwd         ; AX - > DX:AX

		idiv word [c] ; AX = DX:AX / c = b / c = 120 / 12 = 10   DX = DX:AX % c
		mov BX, AX ;BX = b / call
		
		;d * 2
		mov AL, 2
		imul byte [d] ; d * AL -> AX
		
		;b / c - d * 2 BX - AX
		sub BX, AX ; BX = b / c - d * 2 = 10 - 4 = 6
		
		;a + BX
        mov AX, BX
        cwde; AX ->EAX ; EAX = b / c - d * 2 = 10 - 4 = 6
		add EAX, [a] ;EAX = a + b / c - d * 2 = 125 + 6
		
		;EAX - e (quad)
		cdq ; EDX : EAX -> EAX = a + b / c - d * 2
		
		sub EAX, [e] ;EAX = EAX - e and set CF
		sbb EDX, [e + 4] ; EDX = EDX - [e+4] - CF and set a new 
		
		;EDX:EAX
        
        
        
        
	
	push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of