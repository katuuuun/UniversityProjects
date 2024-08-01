#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");

    const int arr_size = 10;
    int* array = new int[arr_size];

    int sum_c = 0;
    int sum_mmx = 0;


    cout << "������ ���������� ����� ��������� ������� ��� ������ MMX" << endl;
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
        movd mm0, sum_mmx   // �������� ������� ����� � MM0
p0:
        movd mm1, [ebx]     // �������� �������� �������� MM1
        paddd mm0,mm1       // ���������� �����
        add ebx, 4          // ������� � ���������� ��������
        loop p0
        movd sum_mmx, mm0   // ������ ���������� � ����������
    }
    delete[] array;
    cout << "����� ��������� �� �� =  " << sum_c << endl;
    cout << "����� ��������� �� ���������� � �������������� MMX =  " << sum_mmx << endl;
    system("pause");
}