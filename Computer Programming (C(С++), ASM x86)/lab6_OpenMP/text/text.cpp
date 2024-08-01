#include <omp.h>
#include <iostream>
using namespace std;
void main() {
	setlocale(LC_ALL, "Russian");
	int count, num;
	omp_set_num_threads(5);
#pragma omp parallel
	{
		count = omp_get_num_threads();
		num = omp_get_thread_num();
		if (num == 0)
			printf("Всего нитей: %d\nНить номер 0\n", count);
		else
			printf("Нить номер %d\n", num);
	}
	system("pause");
}