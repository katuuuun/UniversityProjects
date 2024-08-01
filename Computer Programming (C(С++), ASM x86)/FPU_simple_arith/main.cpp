#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");

    float a = 2.2, b = 8.4, c = 5.87, d = 2.5, y = 0.0;
    cout << "������ ���������� ��������� y = ((a + b)*c)/d ��� ������ FPU" << endl;
    cout << "\t ��� " << "a = " << a << ", b = " << b << ", c = " << c << ", d = " << d << endl;
   
    _asm {
        finit       // ������������� FPU
        fld a       // ��������� a � ����. ST(0) = a
        fld b       // ��������� b � ����. ST(0) = b, ST(1) = a
        fadd        // ������� a � b. ST(0) = ST(0) + ST(1)
        fld c       // ��������� c � ����. ST(0) = c, ST(1) = a+b
        fmul ST(0), ST(1) // �������� (a+b) �� c. ST(0) = ST(0)*ST(1)
        fdiv d      // ��������� (a+b)*c �� d. ST(0) = ST(0) / d
        fst y       // ��������� ��������� � y
        fwait       // �������������
    }

    cout << "��������� y = " << y << endl;
    system("pause");
}