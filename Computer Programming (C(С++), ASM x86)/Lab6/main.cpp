#include <iostream>
#include <conio.h>
#include "wav_lib.h"
using namespace std;
extern "C"{
	int printf(const char* format, ...);
}

int main()
{
	WAVInfo info;
	int h0 = 1;
	int h1 = 4;
	int h2 = 10;
	int h3 = 15;
	int *x, *y, ticksStart, ticksEnd, edx_asm, ticksAsm, edx_c, ticksC;
	x = wavread("src_var_02.wav", info);
	y = new int[info.NumberOfSamples];
	memset(y, 0, sizeof(int)*info.NumberOfSamples);	//Zero array

	_asm {
		xor eax, eax 
		rdtsc // считывание количества тактов с начала работы процессора EDX:EAX
		mov ticksStart, eax // поместить содержимое EAX в ticksStart
	}
	
	for (unsigned int n=7; n<info.NumberOfSamples; n++){
		y[n] = static_cast<int>((h0 * (x[n] + x[n - 7]) + 
			h1 * (x[n - 1] + x[n - 6]) + 
			h2 * (x[n - 2] + x[n - 5]) + 
			h3 * (x[n - 3] + x[n - 4]))/16);
	}

	_asm {
		xor eax, eax 
		rdtsc // считывание количества тактов с начала работы процессора EDX:EAX
		mov ticksEnd, eax // поместить содержимое EAX в ticksEnd
		mov edx_c, edx // поместить содержимое EDX в edx_c
	}

	ticksC = ticksEnd - ticksStart; // находим сколько тактов заняла операция на C
	wavwrite("proc_var_02_C.wav", info, y);

	int* y_asm = new int[info.NumberOfSamples];
	memset(y_asm, 0, sizeof(int) * info.NumberOfSamples);
	
	_asm {
		xor eax, eax 
		rdtsc 
		mov ticksStart, eax 
		
		mov esi, x
		mov edi, y_asm

		mov ecx, info.NumberOfSamples
		cycle :
		mov eax, [esi]
			add eax, [esi - 7 * 4]
			imul h0
			mov ebx, eax


			mov eax, [esi - 1 * 4]
			add eax, [esi - 6 * 4]
			imul h1
			add ebx, eax

			mov eax, [esi - 2 * 4]
			add eax, [esi - 5 * 4]
			imul h2
			add ebx, eax

			mov eax, [esi - 3 * 4]
			add eax, [esi - 4 * 4]
			imul h3
			add ebx, eax

			sar ebx, 4

			mov[edi], ebx
			add esi, 4
			add edi, 4
			loop cycle

			xor eax, eax 
			rdtsc 
			mov ticksEnd, eax 
			mov edx_asm, edx 
	}

	ticksAsm = ticksEnd - ticksStart; 

	wavwrite("proc_var_02_Asm.wav", info, y_asm);
	printf_s("Ticks on Asm: %d\n", ticksAsm);
	printf_s("Ticks on C: %d\n", ticksC);
	ticksC = ticksC - ticksAsm;
	printf_s("Asm faster on: %d ticks\n", ticksC);

	delete [] x;
	delete [] y;
	printf_s("Press any key... ");
	_getch();
}
