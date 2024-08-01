#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");

    const int arr_size = 5;
    float* array = new float[arr_size];
    float sum_c = 0.0;
    float sum_fpu = 0.0;

    cout << "������ ���������� ����� ��������� ������� ��� ������ FPU" << endl;
    cout << "������� " << arr_size << " ���������:" << endl;

    for (short i = 0; i < arr_size; i++)
        cin >> array[i];

    for (short i = 0; i < arr_size; i++)
        cout << "array[" << i << "] = " << array[i] << endl;

    for (short i = 0; i < arr_size; i++)
        sum_c = sum_c + array[i];

    _asm {
        mov ebx, array      // ����� ������� � ebx
        mov ecx, arr_size   // ������ ������� � ecx
        
        finit               // ������������� FPU
        fld sum_fpu         // �������� ������� ����� � ST(0)
p0:
        fld dword ptr [ebx] // �������� �������� �������� � ST(0). ST(1) = sum_fpu 
        fadd                // ���������� �����. ST(0) = ST(0)+ST(1) 
        add ebx, 4          // ������� � ���������� ��������
        loop p0             // ���� ���� ecx!=0
        fst sum_fpu         // ���������� ���������� � sum_fpu
        fwait               // �������������
    }
    delete[] array;
    cout << "����� ��������� �� �� =  " << sum_c << endl;
    cout << "����� ��������� �� ���������� � �������������� FPU =  " << sum_fpu << endl;
    system("pause");
}