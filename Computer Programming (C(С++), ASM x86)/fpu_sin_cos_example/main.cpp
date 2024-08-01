#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");

    float x = 2.2, y = 0.0;
    const int one = 1;
    const int two = 2;
    cout << "������ ���������� ��������� y = (sin(x+1))/(cos(x)+2) ��� ������ FPU" << endl;
    cout << "\t ��� " << "x = " << x << endl;

    _asm {
        finit       // ������������� FPU
        fld x       // ��������� x � ����. ST(0) = x
        fiadd one   // ��������� � ST(0) ������������� ������� = ST(0) = ST(0)+1 = x+1 
        fsin        // ��������� �����. ST(0) = sin(ST(0)) = sin(x+1)
        fld x       // ��������� � ���� x. ST(0) = x, ST(1) = sin(x+1)
        fcos        // ��������� ������� x. ST(0) = cos(ST(0) = cos(x). ST(1) = sin(x+1)
        fiadd two   // ��������� � ST(0) ������������� ������. ST(0) = ST(0)+2 = cos(x)+2. ST(1) = sin(x+1)
        fdiv        // ��������� sin(x+1) �� cos(x)+2. ST(1)=ST(1)/ST(0), ����� ���������� �� ����� ������� �������
                    // ��������� � ����� ��������� � ST(0)
        fst y       // ��������� ��������� � y      
        fwait       // �������������
    }

    cout << "��������� y = " << y << endl;
    system("pause");
}