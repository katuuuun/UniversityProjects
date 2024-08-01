//#include <iostream>
//#include <vector>
//#include <cmath>
//#include <omp.h>
//#include <cstdlib>
//#include <chrono>
//
//// Функция для инициализации массива случайными значениями
//void initializeArray(std::vector<double>& array) {
//    for (auto& elem : array) {
//        elem = static_cast<double>(rand()) / RAND_MAX * 100.0;
//    }
//}
//
//// Последовательная реализация вычисления суммы квадратных корней
//double sequentialSumOfSqrt(const std::vector<double>& array) {
//    double sum = 0.0;
//    for (const auto& elem : array) {
//        sum += std::sqrt(elem);
//    }
//    return sum;
//}
//
//// Параллельная реализация вычисления суммы квадратных корней с использованием OpenMP
//double parallelSumOfSqrt(const std::vector<double>& array, int num_threads) {
//    std::vector<double> partial_sums(num_threads, 0.0);
//    int n = array.size();
//
//#pragma omp parallel num_threads(num_threads)
//    {
//        int thread_id = omp_get_thread_num();
//        int chunk_size = n / num_threads;
//        int start = thread_id * chunk_size;
//        int end = (thread_id == num_threads - 1) ? n : start + chunk_size;
//
//        for (int i = start; i < end; ++i) {
//            partial_sums[thread_id] += std::sqrt(array[i]);
//        }
//    }
//
//    double total_sum = 0.0;
//    for (const auto& partial_sum : partial_sums) {
//        total_sum += partial_sum;
//    }
//
//    return total_sum;
//}
//
//int main() {
//    int array_size;
//    int num_threads;
//
//    std::cout << "Enter the size of the array: ";
//    std::cin >> array_size;
//
//    std::cout << "Enter the number of threads: ";
//    std::cin >> num_threads;
//
//    std::vector<double> array(array_size);
//    initializeArray(array);
//    for (size_t i = 0; i < array_size; i++)
//    {
//        std::cout << array[i] << std::endl;
//    }
//
//
//
//    // Измерение времени последовательной реализации
//    double start_time, end_time;
//    start_time = omp_get_wtime();
//    
//
//
//    auto start = std::chrono::high_resolution_clock::now();
//    double sequential_result = sequentialSumOfSqrt(array);
//    auto end = std::chrono::high_resolution_clock::now();
//    std::chrono::duration<double> sequential_duration = end - start;
//
//
//    end_time = omp_get_wtime();
//    std::cout << "time:" << end_time - start_time << std::endl;
//    std::cout << "Sequential result: " << sequential_result << "\n";
//
//    // Измерение времени параллельной реализации
//
//    start_time = omp_get_wtime();
//
//    start = std::chrono::high_resolution_clock::now();
//    double parallel_result = parallelSumOfSqrt(array, num_threads);
//    end = std::chrono::high_resolution_clock::now();
//    std::chrono::duration<double> parallel_duration = end - start;
//
//
//    end_time = omp_get_wtime();
//    std::cout.precision(10);
//    std::cout << "time:" << end_time - start_time << std::endl;
//    std::cout << "Parallel result: " << parallel_result << "\n";
//
//    return 0;
//}
