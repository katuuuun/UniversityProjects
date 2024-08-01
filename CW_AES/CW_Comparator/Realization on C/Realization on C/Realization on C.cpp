#include <stdio.h>
#include <stdlib.h>
// 16-bit Binary Comparator function


int main(){
    int a[10] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    int greater, equal, smaller;

    printf("Binary Comparator Test Results:\n");
    printf("-------------------------------\n");

    for (int i = 1; i < 6; i++) {
        binaryComparator(numbersA[i], numbersB[i], &greater, &equal, &smaller);
        printf("Test Case %d:\n", i + 1);
        printf("A: %u, B: %u\n", numbersA[i], numbersB[i]);
        printf("Greater: %d, Equal: %d, Smaller: %d\n", greater, equal, smaller);
        printf("-----------------\n");
    }

    return 0;
}

void binaryComparator(unsigned short a, unsigned short b, int* greater, int* equal, int* smaller)
{
    if (a > b) {
        *greater = 1;
        *equal = 0;
        *smaller = 0;
    }
    else if (a == b) {
        *greater = 0;
        *equal = 1;
        *smaller = 0;
    }
    else {
        *greater = 0;
        *equal = 0;
        *smaller = 1;
    }
}