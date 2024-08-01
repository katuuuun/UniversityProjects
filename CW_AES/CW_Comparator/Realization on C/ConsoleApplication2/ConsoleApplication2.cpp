#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdbool.h>


bool compareFiles(const char* outputC, const char* VHDL) {
    FILE* file1 = fopen("outputC.txt", "r+");
    FILE* file2 = fopen("VHDL.txt", "r+");
    char ch1, ch2;
    if (file1 == NULL || file2 == NULL) {
        printf("Mission failed.\n");
        return false;
    }

    bool identical = true;

    while ((ch1 = fgetc(file1)) != EOF && (ch2 = fgetc(file2)) != EOF) {
        printf("%ch1 and %ch2\n", ch1, ch2);
        if (ch1 != ch2) {
            
            identical = false;
            break;
        }
    }
    fclose(file1);
    fclose(file2);

    return identical;
}
int main() {
    if (compareFiles("outputC.txt", "VHDL.txt")) {
        printf("files outputC.txt & VHDL.txt are equal.\n");
    }
    else {
        printf("files outputC.txt & VHDL.txt are not equal.\n");
    }

    return 0;
}