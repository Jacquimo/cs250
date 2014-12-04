#include <stdio.h>

void main() {

        /* able to read up to 100 ints */
        int array[100];
        int num_elements = 0;
        int j = 0;

        /* read integers from stdin until a character is input (or non-number value) */ 
        while (scanf("%d", &array[num_elements])) {
                num_elements++;
        } 

        /* This is the subroutine you need to implement in X86 assembly. */
        bubble(num_elements, array);

        /* print out the sorted array */
        for (j = 0; j < num_elements; j++) {
                printf("%d\n", array[j]);
        }
}