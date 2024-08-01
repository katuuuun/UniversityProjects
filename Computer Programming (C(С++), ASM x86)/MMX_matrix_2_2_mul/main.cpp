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

    cout << "Пример вычисления произведения квадратных матриц 2x2 при помощи MMX" << endl;
    cout << "Введите элементы матрицы 1" << endl;

    for (int i = 0; i < row_size; i++)
        for (int j = 0; j < col_size; j++)
            cin >> *(matrix_1 + i * col_size + j);

    cout << "Введите элементы матрицы 2" << endl;

    for (int i = 0; i < row_size; i++)
        for (int j = 0; j < col_size; j++)
            cin >> *(matrix_2 + i * col_size + j);

    cout << "Матрица 1:" << endl;

    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < col_size; j++) {
            cout << *(matrix_1 + i * col_size + j) << " ";
        }
        cout << endl;
    }

    cout << "Матрица 2:" << endl;

    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < col_size; j++) {
            cout << *(matrix_2 + i * col_size + j) << " ";
        }
        cout << endl;
    }

// Вычисление произведения матриц
    for (int i = 0; i < row_size; i++)
        for (int j = 0; j < col_size; j++)
            *(matrix_c + i * col_size + j) = *(matrix_1 + i * col_size + j) * *(matrix_2 + i * col_size + j);

    cout << "Результат произведения матриц на СИ:" << endl;
    for (int i = 0; i < row_size; i++) {
        for (int j = 0; j < col_size; j++) {
            cout << *(matrix_c + i * col_size + j) << " ";
        }
        cout << endl;
    }

    _asm {
        mov esi, matrix_1      // Адрес матрицы 1 в esi
        mov edi, matrix_2      // Адрес матрицы 2 edi   
        mov ebx, matrix_MMX    // Адрес итоговой матрицы в ebx
        mov ecx, row_size      // Количество строк = количество столбцов

p0:     movd mm0, [esi]        // Загрузка текущей строки матрицы 1 в MM0 (берём по 2 элемента сразу)
        movd mm1, [edi]        // Загрузка текущей строки матрицы 2 в MM1 (берём по 2 элемента сразу)
        pmullw mm0, mm1        // Умножение строк матриц
        movd [ebx], mm0        // Запись результата в итоговую матрицы  (по 2 элемента сразу)

        add esi, 4             // Переход к следующей строке матрицы 1
        add edi, 4             // Переход к следующей строке матрицы 2
        add ebx, 4             // Переход к следующей строке итоговой матрицы

        loop p0                // Цикл по строкам
    }

    cout << "Результат произведения матриц 2x2 при помощи MMX:" << endl;

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