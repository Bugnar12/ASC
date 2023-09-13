#include <stdio.h>

int asm_module(int n); //the asm module


int main(){

    int n = 5; //the number of numbers that need to be read
    int result = 0; 
    int n1 = 0;
    
    int str[101]; //the string that is read
    int final_str[101];
    
    printf("Your input the numbers \n");
    
    
    for(int i = 0; i < n; i++)
    {
        scanf("%d", &str[i]);
        result = asm_module(str[i]); //calling the asm module, the result gets eax from the module
        final_str[++n1] = result;
    }
    
    for(int i = 1; i <= n1; i++)
        printf("%d ", final_str[i]); //printing the digints appended to the array
      
}
