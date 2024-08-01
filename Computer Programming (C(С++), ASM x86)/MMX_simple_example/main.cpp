#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");
    int a = 10, b = 8, c = 5, d = 2, y = 0;
    cout << "������ ���������� ��������� y = (a + b*c)/d ��� ������ MMX" << endl;
    cout << "\t ��� " << "a = " << a << ", b = " << b << ", c = " << c << ", d = " << d << endl;
   
    _asm {
        movd mm0,a      // �������� �������� ����� (a) � MM0
        movd mm1,b      // �������� �������� ����� (b) � MM1
        pmullw mm1,c    // ������� MM1 �� ������� ����� (c)
        paddw mm0,mm1   // �������� ������� ����
        movd eax, mm0   // ���������� �������� ����� � ����������
        /*���������� MMX �� ������������ ������ �������, ������� ��������� ��� ����� ������� ������� idiv*/
        cdq             // ���������� ����� � eax �� EDX:EAX
        idiv d          // ������� EDX:EAX �� d 
        mov y, eax      // ���������� �������� � ���������� y
    }

    cout << "��������� y = " << y << endl;
    system("pause");
}