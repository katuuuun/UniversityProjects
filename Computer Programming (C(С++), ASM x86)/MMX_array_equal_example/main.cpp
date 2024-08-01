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

    cout << "Пример определения количества элементов, равных заданному при помощи MMX" << endl;
    cout << "Введите " << arr_size << " элементов:" << endl;

    for (short i = 0; i < arr_size; i++)
        cin >> array[i];

    cout << "Введите элемент для сравнения" << endl;
    cin >> element;

    for (short i = 0; i < arr_size; i++)
        cout << "array[" << i << "] = " << array[i] << endl;

    for (short i = 0; i < arr_size; i++)
        if (array[i] == element)
            cnt_c++;

    _asm {
        mov ebx, array      // Адрес массива в ebx
        mov ecx, arr_size   // Размер массива в ecx
        mov edx, cnt_mmx    // Количество равных заданному элементу
        movd mm1, element   // Заданный элемент для сравнения в MM1
p0:
        movd mm0, [ebx]     // Загрузка текущего элемента массива в MM0
        pcmpeqd mm0, mm1    // Сравнение на равенство элементов
        movd eax, mm0       // Пересылка результата сравнения в EAX
        test eax, eax       // Логическое И результата сравнения
        jz not_eq           // Если результат 0 - элементы не равны, если 1 - равны
        inc edx             // Увеличение счётчика если элементы равны
not_eq:
        add ebx, 4          // Переход к следующему элементу
        loop p0             // Цикл
        mov cnt_mmx, edx    // Запись результата в переменную
    }
    delete[] array;
    cout << "Количество элементов равных заданному на СИ =  " << cnt_c << endl;
    cout << "Количество элементов равных заданному на ассемблере с использованием MMX =  " << cnt_mmx << endl;
    system("pause");
}