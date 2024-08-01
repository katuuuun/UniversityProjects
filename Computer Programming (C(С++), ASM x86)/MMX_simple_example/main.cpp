#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");
    int a = 10, b = 8, c = 5, d = 2, y = 0;
    cout << "Пример вычисления выражения y = (a + b*c)/d при помощи MMX" << endl;
    cout << "\t где " << "a = " << a << ", b = " << b << ", c = " << c << ", d = " << d << endl;
   
    _asm {
        movd mm0,a      // Загрузка двойного слова (a) в MM0
        movd mm1,b      // Загрузка двойного слова (b) в MM1
        pmullw mm1,c    // Младшее MM1 на двойное слово (c)
        paddw mm0,mm1   // Сложение двойных слов
        movd eax, mm0   // Сохранение двойного слова в переменную
        /*Технология MMX не поддерживает команд деления, поэтому выполняем его через базовую команду idiv*/
        cdq             // Расширение знака в eax до EDX:EAX
        idiv d          // Деление EDX:EAX на d 
        mov y, eax      // Сохранение частного в переменную y
    }

    cout << "Результат y = " << y << endl;
    system("pause");
}