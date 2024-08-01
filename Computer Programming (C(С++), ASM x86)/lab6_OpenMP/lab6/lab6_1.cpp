#include <iostream>
#include <cmath>
#include <omp.h>
#include <locale.h>

using namespace std;

double calculate_open(double X, int N, int num_threads) {
    double result = 0.0;

#pragma omp parallel num_threads(num_threads) reduction(+:result)
    {
        int thread_count = omp_get_num_threads();
#pragma omp for
        for (int i = 1; i <= N; ++i) {
            double inner_sum = 0.0;
            for (int j = i; j <= N; ++j) {
                inner_sum += (j + pow(X + j, 0.14)) / (2 * i * j - 1);
            }
            result += 1 / inner_sum;
        }
    }

    return result;
}

    double calculate_C(double X, int N) {
        double result = 0.0;
        for (int i = 1; i <= N; ++i) {
            double inner_sum = 0.0;
            for (int j = i; j <= N; ++j) {
                inner_sum += (j + pow(X + j, 0.14)) / (2 * i * j - 1);
            }
            result += 1 / inner_sum;
        }
        return result;
    }

    int main() {


        int N=10000;
        double X;
        int num_threads;

        cout << "Input X: ";
        cin >> X;
        cout << "Threads: ";
        cin >> num_threads;


        double start_time = omp_get_wtime();
        double result_OPEN = calculate_open(X, N, num_threads);
        double end_time = omp_get_wtime();
        double time_taken_open = end_time - start_time;

        start_time = omp_get_wtime();
        double result_C = calculate_C(X, N);
        end_time = omp_get_wtime();
        double time_taken_c = end_time - start_time;

        cout << "\nOPEN\t\t\t\tC" << endl;

        cout << "\nF(X, N) OPEN = " << result_OPEN << "\t\tF(X, N) C = " << result_C << endl;
        cout << "\nt = : " << time_taken_open << " s" << "\t\tt = : " << time_taken_c << " s" << endl;

        return 0;
    }