//#include <iostream>
//#include <vector>
//#include <cstdlib>
//#include <ctime>
//#include <omp.h>
//
//// Function to initialize the matrix with random values
//void initialize_matrix(std::vector<std::vector<double>>& matrix) {
//    int size = matrix.size();
//    for (int i = 0; i < size; ++i) {
//        for (int j = 0; j < size; ++j) {
//            matrix[i][j] = static_cast<double>(rand()) / RAND_MAX * 100.0; // Values from 0 to 100
//        }
//    }
//}
//
//// Sequential implementation
//double sum_main_diagonal_sequential(const std::vector<std::vector<double>>& matrix) {
//    double sum = 0.0;
//    int size = matrix.size();
//    for (int i = 0; i < size; ++i) {
//        sum += matrix[i][i];
//    }
//    return sum;
//}
//
//// Parallel implementation using OpenMP
//double sum_main_diagonal_parallel(const std::vector<std::vector<double>>& matrix, int num_threads) {
//    double sum = 0.0;
//    int size = matrix.size();
//
//#pragma omp parallel for reduction(+:sum) num_threads(num_threads)
//    for (int i = 0; i < size; ++i) {
//        sum += matrix[i][i];
//    }
//
//    return sum;
//}
//
//int main() {
//    int size, num_threads;
//
//    // Input size of the matrix
//    std::cout << "Enter the size of the matrix: ";
//    std::cin >> size;
//
//    // Input number of threads
//    std::cout << "Enter the number of threads: ";
//    std::cin >> num_threads;
//
//    // Allocate memory for the matrix and initialize
//    std::vector<std::vector<double>> matrix(size, std::vector<double>(size));
//    srand(static_cast<unsigned int>(time(0)));
//    initialize_matrix(matrix);
//
//    // Sequential execution
//    double start_time = omp_get_wtime();
//    double sequential_sum = sum_main_diagonal_sequential(matrix);
//    double sequential_time = omp_get_wtime() - start_time;
//
//    // Parallel execution
//    start_time = omp_get_wtime();
//    double parallel_sum = sum_main_diagonal_parallel(matrix, num_threads);
//    double parallel_time = omp_get_wtime() - start_time;
//
//    // Output results
//    std::cout << "Sequential sum: " << sequential_sum << ", time: " << sequential_time << " seconds\n";
//    std::cout << "Parallel sum: " << parallel_sum << ", time: " << parallel_time << " seconds\n";
//
//    return 0;
//}