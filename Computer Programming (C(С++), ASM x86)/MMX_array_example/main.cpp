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


    cout << "Пример вычисления суммы элементов массива при помощи MMX" << endl;
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
        movd mm0, sum_mmx   // Загрузка текущей суммы в MM0
p0:
        movd mm1, [ebx]     // Загрузка текущего элемента MM1
        paddd mm0,mm1       // Накопление суммы
        add ebx, 4          // Переход к следующему элементу
        loop p0
        movd sum_mmx, mm0   // Запись результата в переменную
    }
    delete[] array;
    cout << "Сумма элементов на СИ =  " << sum_c << endl;
    cout << "Сумма элементов на ассемблере с использованием MMX =  " << sum_mmx << endl;
    system("pause");
}