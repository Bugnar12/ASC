;I will solve the 23th problem from the Instructions working on strings of bytes/words/doublewords set which states that : 

;Being given a string of bytes, build a string of words which contains in the low bytes of the words 
;the set of distinct characters from the given string and in the high byte of a word 
;it contains the number of occurrences of the low byte of the word in the given byte string.

;result is 0402h, 0304h, 0105h

;Firstly from the array I will compute the low part of the word containing unique values from the array
;Secondly, from the array computed I will take values one by one and check how many times they appear in the first array,
;then the result is going to go into the high part of the word

bits 32 ;assembling for the 32 bits architecture
; the start label will be the entry point in the program
global  start 
    
extern  exit ; we inform the assembler that the exit symbol is foreign, i.e. it exists even if we won't be defining it

import  exit msvcrt.dll; exit is a function that ends the process, it is defined in msvcrt.dll
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
segment  data use32 class=data ; the data segment where the variables are declared 

    s1 DB 2, 4, 2, 5, 2, 2, 4, 4 
    lensir equ $ - s1 ;the length of the initial string of BYTES
    s2 times lensir dw 0
    
    
segment  code use32 class=code ; code segment
    start:
        ;we put in the low byte of the word the unique numbers from the array
        mov esi, 0 ;index for the first array
        mov edi, 1 ;index for the second array
        mov al, [s1+esi]
        mov [s2+edi], al ; the first element from the second array is now 1(THE FIRST EL. FROM THE FIRST ARRAY)
        cld
        mov esi, s1
        mov ecx, lensir
        
        jecxz end_bucla
        for1:
            lodsb
            mov ebp, 0 ;ebp loops through the second array as many times as the number of elements in it
            for2:
                mov bl, [s2+ebp]
                cmp al, bl
                je not_add_array
                cmp ebp, edi
                jle check
            jmp add_array
               
            check:
                inc ebp
                jmp for2
            
             not_add_array:
                dec ecx
                cmp ecx, 0
                je end_bucla
                jmp for1
            
            add_array:
                mov[s2+edi], al ;we move the corresponding element into the second array
                inc edi ;we increment to move to the next position
                inc edi
                cmp ecx, 0
                je end_bucla
            
        loop for1
        
        end_bucla:
        
        ;we put in the high bytes of the word the nr. of appearences of the unique numbers in the array
        
        cld
        mov ecx, edi ;ecx is now 6
        mov ebp, esi ;in ebp we have the size of the array
        mov edi, 1 ; index for the second array
        
        
        repeta:
            mov bl, [s2+edi] ;bl is now the UNIQUE ELEMENT
            mov esi, s1
            repeta2:
                lodsb ;al <- es:esi , esi += 1
                cmp al, bl
                je increment
                cmp esi, ebp ;equal if we parsed the first array completely
                jle checking
            jmp add_array_2
            
            checking:
                jmp repeta2
            
            increment:
                inc dl ; dl represents the number of appearences
                jmp repeta2
                
            add_array_2: ;we must transfer dl into the high byte of the word (nr. of appearences)
                dec edi
                mov [s2+edi], dl
                mov dl, 0
                
                add edi, 3 ;we return to the low byte
                dec ecx
                jecxz the_end2
                dec ecx
        
        loop repeta
        
        the_end2:
        
        ;exit(0)
                
       
	
	push   dword 0 ;saves on stack the parameter of the function exit
	call   [exit] ; function exit is called in order to end the execution of