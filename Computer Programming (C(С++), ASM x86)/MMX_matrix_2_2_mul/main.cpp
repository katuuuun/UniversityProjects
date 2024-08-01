#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");

    const int row_size = 2;
    const int col_size = row_size;

    short* matrix_1 = new short[row_size*col_size];
    short* matrix_2 = new short[row_size*col_size];
    short* matrix_c = new short[row_size*col_size];
    short* matrix_MMX = new short[row_size * col_size];

    cout << "������ ���������� ������������ ���������� ������ 2x2 ��� ������ MMX" << endl;
    cout << "������� �������� ������� 1" << endl;

    for (int i = 0; i < row_size; i++)
        for (int j = 0; j < col_size; j++)
            cin >> *(matrix_1 + i * col_size + j);

    cout << "������� �������� ������� 2" << endl;

    for (int i = 0; i < row_size; i++)
        for (int j = 0; j < col_size; j++)
            cin >> *(matrix_2 + i * col_size + j);

    cout << "������� 1:" << endl;

    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < col_size; j++) {
            cout << *(matrix_1 + i * col_size + j) << " ";
        }
        cout << endl;
    }

    cout << "������� 2:" << endl;

    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < col_size; j++) {
            cout << *(matrix_2 + i * col_size + j) << " ";
        }
        cout << endl;
    }

// ���������� ������������ ������
    for (int i = 0; i < row_size; i++)
        for (int j = 0; j < col_size; j++)
            *(matrix_c + i * col_size + j) = *(matrix_1 + i * col_size + j) * *(matrix_2 + i * col_size + j);

    cout << "��������� ������������ ������ �� ��:" << endl;
    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < col_size; j++) {
            cout << *(matrix_c + i * col_size + j) << " ";
        }
        cout << endl;
    }

    _asm {
        mov esi, matrix_1      // ����� ������� 1 � esi
        mov edi, matrix_2      // ����� ������� 2 edi   
        mov ebx, matrix_MMX    // ����� �������� ������� � ebx
        mov ecx, row_size      // ���������� ����� = ���������� ��������

p0:     movd mm0, [esi]        // �������� ������� ������ ������� 1 � MM0 (���� �� 2 �������� �����)
        movd mm1, [edi]        // �������� ������� ������ ������� 2 � MM1 (���� �� 2 �������� �����)
        pmullw mm0, mm1        // ��������� ����� ������
        movd [ebx], mm0        // ������ ���������� � �������� �������  (�� 2 �������� �����)

        add esi, 4             // ������� � ��������� ������ ������� 1
        add edi, 4             // ������� � ��������� ������ ������� 2
        add ebx, 4             // ������� � ��������� ������ �������� �������

        loop p0                // ���� �� �������
    }

    cout << "��������� ������������ ������ 2x2 ��� ������ MMX:" << endl;

    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < col_size; j++) {
            cout << *(matrix_MMX + i * col_size + j) << " ";
        }
        cout << endl;
    }
    delete[] matrix_1;
    delete[] matrix_2;
    delete[] matrix_c;
    delete[] matrix_MMX;

    system("pause");
}