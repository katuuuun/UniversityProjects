//#include <iostream>
//#include <vector>
//#include <cstdlib>
//#include <omp.h>
//#include <chrono>
//
//
//void initializeArray(std::vector<double>& array) {
//    for (auto& elem : array) {
//        elem = static_cast<double>(rand()) / RAND_MAX * 100.0;
//    }
//}
//
//
//int sequentialCount(const std::vector<double>& array, double threshold) {
//    int count = 0;
//    for (const auto& elem : array) {
//        if (elem <= threshold) {
//            ++count;
//        }
//    }
//    return count;
//}
//
//
//int parallelCount(const std::vector<double>& array, double threshold, int num_threads) {
//    int count = 0;
//    int n = array.size();
//
//#pragma omp parallel for reduction(+:count) num_threads(num_threads)
//    for (int i = 0; i < n; ++i) {
//        if (array[i] <= threshold) {
//            ++count;
//        }
//    }
//
//    return count;
//}
//
//int main() {
//    int array_size;
//    int num_threads;
//    double threshold;
//
//    std::cout << "Enter the size of the array: ";
//    std::cin >> array_size;
//
//    std::cout << "Enter the number of threads: ";
//    std::cin >> num_threads;
//
//    std::cout << "Enter the threshold value: ";
//    std::cin >> threshold;
//
//    std::vector<double> array(array_size);
//    initializeArray(array);
//
//  
//    auto start = std::chrono::high_resolution_clock::now();
//    int sequential_result = sequentialCount(array, threshold);
//    auto end = std::chrono::high_resolution_clock::now();
//    std::chrono::duration<double> sequential_duration = end - start;
//
//    std::cout << "Sequential result: " << sequential_result << "\n";
//    std::cout << "Sequential duration: " << sequential_duration.count() << " seconds\n";
//
//    
//    start = std::chrono::high_resolution_clock::now();
//    int parallel_result = parallelCount(array, threshold, num_threads);
//    end = std::chrono::high_resolution_clock::now();
//    std::chrono::duration<double> parallel_duration = end - start;
//
//    std::cout << "Parallel result: " << parallel_result << "\n";
//    std::cout << "Parallel duration: " << parallel_duration.count() << " seconds\n";
//
//    return 0;
//}
