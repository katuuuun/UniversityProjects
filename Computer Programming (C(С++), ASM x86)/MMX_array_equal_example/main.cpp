#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");

    const int arr_size = 10;
    int* array = new int[arr_size];
    
    int element = 0;

    int cnt_c = 0;
    int cnt_mmx = 0;

    cout << "������ ����������� ���������� ���������, ������ ��������� ��� ������ MMX" << endl;
    cout << "������� " << arr_size << " ���������:" << endl;

    for (short i = 0; i < arr_size; i++)
        cin >> array[i];

    cout << "������� ������� ��� ���������" << endl;
    cin >> element;

    for (short i = 0; i < arr_size; i++)
        cout << "array[" << i << "] = " << array[i] << endl;

    for (short i = 0; i < arr_size; i++)
        if (array[i] == element)
            cnt_c++;

    _asm {
        mov ebx, array      // ����� ������� � ebx
        mov ecx, arr_size   // ������ ������� � ecx
        mov edx, cnt_mmx    // ���������� ������ ��������� ��������
        movd mm1, element   // �������� ������� ��� ��������� � MM1
p0:
        movd mm0, [ebx]     // �������� �������� �������� ������� � MM0
        pcmpeqd mm0, mm1    // ��������� �� ��������� ���������
        movd eax, mm0       // ��������� ���������� ��������� � EAX
        test eax, eax       // ���������� � ���������� ���������
        jz not_eq           // ���� ��������� 0 - �������� �� �����, ���� 1 - �����
        inc edx             // ���������� �������� ���� �������� �����
not_eq:
        add ebx, 4          // ������� � ���������� ��������
        loop p0             // ����
        mov cnt_mmx, edx    // ������ ���������� � ����������
    }
    delete[] array;
    cout << "���������� ��������� ������ ��������� �� �� =  " << cnt_c << endl;
    cout << "���������� ��������� ������ ��������� �� ���������� � �������������� MMX =  " << cnt_mmx << endl;
    system("pause");
}