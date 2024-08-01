#include <iostream>
#pragma inline
using namespace std;

void main()
{
    setlocale(LC_ALL, "Russian");

    float x = 2.2, y = 0.0;
    const int one = 1;
    const int two = 2;
    cout << "Пример вычисления выражения y = (sin(x+1))/(cos(x)+2) при помощи FPU" << endl;
    cout << "\t где " << "x = " << x << endl;

    _asm {
        finit       // Инициализация FPU
        fld x       // Загрузить x в стек. ST(0) = x
        fiadd one   // Прибавить к ST(0) целочисленную единицу = ST(0) = ST(0)+1 = x+1 
        fsin        // Вычислить синус. ST(0) = sin(ST(0)) = sin(x+1)
        fld x       // Загрузить в стек x. ST(0) = x, ST(1) = sin(x+1)
        fcos        // Вычислить косинус x. ST(0) = cos(ST(0) = cos(x). ST(1) = sin(x+1)
        fiadd two   // Прибавить к ST(0) целочисленную двойку. ST(0) = ST(0)+2 = cos(x)+2. ST(1) = sin(x+1)
        fdiv        // Разделить sin(x+1) на cos(x)+2. ST(1)=ST(1)/ST(0), далее вытолкнуть из стека верхний элемент
                    // результат в итоге запишется в ST(0)
        fst y       // Сохранить результат в y      
        fwait       // Синхронизация
    }

    cout << "Результат y = " << y << endl;
    system("pause");
}