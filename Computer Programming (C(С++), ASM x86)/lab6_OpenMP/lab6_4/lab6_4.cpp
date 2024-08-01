//#include <iostream>
//#include <vector>
//#include <cstdlib>
//#include <ctime>
//#include <omp.h>
//#include <algorithm>
//#include <cmath>
//#include <locale.h>
//
//// Функция для инициализации массива случайными значениями
//void initialize_array(std::vector<double>& array) {
//    for (auto& val : array) {
//        val = static_cast<double>(rand()) / RAND_MAX * 100.0; // Значения от 0 до 100
//    }
//}
//
//// Последовательная реализация
//void process_array_sequential(std::vector<double>& array) {
//    int size = array.size();
//    double sum = 0.0;
//    double min_val = array[0];
//    double max_val = array[0];
//
//    // Вычисление суммы, минимального и максимального значений
//    for (int i = 0; i < size; ++i) {
//        sum += array[i];
//        if (array[i] < min_val) min_val = array[i];
//        if (array[i] > max_val) max_val = array[i];
//    }
//
//    double mean = sum / size;
//
//    // Нормализация и округление
//    for (int i = 0; i < size; ++i) {
//        array[i] = round((array[i] - min_val) / (max_val - min_val) * 100.0);
//    }
//}
//
//// Параллельная реализация с использованием OpenMP
//void process_array_parallel(std::vector<double>& array, int num_threads) {
//    int size = array.size();
//    double sum = 0.0;
//    double min_val = array[0];
//    double max_val = array[0];
//
//    // Вычисление суммы, минимального и максимального значений
//#pragma omp parallel num_threads(num_threads)
//    {
//        double local_sum = 0.0;
//        double local_min = array[0];
//        double local_max = array[0];
//
//#pragma omp for nowait
//        for (int i = 0; i < size; ++i) {
//            local_sum += array[i];
//            if (array[i] < local_min) local_min = array[i];
//            if (array[i] > local_max) local_max = array[i];
//        }
//
//#pragma omp critical
//        {
//            sum += local_sum;
//            if (local_min < min_val) min_val = local_min;
//            if (local_max > max_val) max_val = local_max;
//        }
//    }
//
//    double mean = sum / size;
//
//    // Нормализация и округление
//#pragma omp parallel for num_threads(num_threads)
//    for (int i = 0; i < size; ++i) {
//        array[i] = round((array[i] - min_val) / (max_val - min_val) * 100.0);
//    }
//}
//
//int main() {
//    setlocale(LC_ALL, "Russian");
//    int size, num_threads;
//
//    // Ввод размера массива
//    std::cout << "Введите размер массива: ";
//    std::cin >> size;
//
//    // Ввод количества потоков
//    std::cout << "Введите количество потоков: ";
//    std::cin >> num_threads;
//
//    // Выделение памяти для массива и инициализация
//    std::vector<double> array(size);
//    srand(static_cast<unsigned int>(time(0)));
//    initialize_array(array);
//
//    //std::cout << "Array is:" << std::endl;
//    //for (size_t i = 0; i < size; i++)
//    //{
//    //    std::cout << array[i] << std::endl;
//    //}
//
//    // Копия массива для последовательной обработки
//    std::vector<double> array_seq = array;
//
//    // Последовательное выполнение
//    double start_time = omp_get_wtime();
//    process_array_sequential(array_seq);
//    double sequential_time = omp_get_wtime() - start_time;
//
//    // Параллельное выполнение
//    start_time = omp_get_wtime();
//    process_array_parallel(array, num_threads);
//    double parallel_time = omp_get_wtime() - start_time;
//
//   /* std::cout << "Array is:" << std::endl;
//    for (size_t i = 0; i < size; i++)
//    {
//        std::cout << array[i] << std::endl;
//    }*/
//
//    // Вывод результатов
//    std::cout << "Последовательная обработка, время: " << sequential_time << " секунд\n";
//    std::cout << "Параллельная обработка, время: " << parallel_time << " секунд\n";
//
//    return 0;
//}