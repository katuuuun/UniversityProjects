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

    cout << "Пример вычисления суммы элементов массива при помощи FPU" << endl;
    cout << "Введите " << arr_size << " элементов:" << endl;

    for (short i = 0; i < arr_size; i++)
        cin >> array[i];

    for (short i = 0; i < arr_size; i++)
        cout << "array[" << i << "] = " << array[i] << endl;

    for (short i = 0; i < arr_size; i++)
        sum_c = sum_c + array[i];

    _asm {
        mov ebx, array      // Адрес массива в ebx
        mov ecx, arr_size   // Размер массива в ecx
        
        finit               // Инициализация FPU
        fld sum_fpu         // Загрузка текущей суммы в ST(0)
p0:
        fld dword ptr [ebx] // Загрузка текущего элемента в ST(0). ST(1) = sum_fpu 
        fadd                // Вычисление суммы. ST(0) = ST(0)+ST(1) 
        add ebx, 4          // Переход к следующему элементу
        loop p0             // Цикл пока ecx!=0
        fst sum_fpu         // Сохранения результата в sum_fpu
        fwait               // Синхронизация
    }
    delete[] array;
    cout << "Сумма элементов на СИ =  " << sum_c << endl;
    cout << "Сумма элементов на ассемблере с использованием FPU =  " << sum_fpu << endl;
    system("pause");
}