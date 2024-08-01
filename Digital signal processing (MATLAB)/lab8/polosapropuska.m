clearvars
clc

% function x(t)
t1 = 0.2;
t2 = 0.8;
T = 1; 
t = 0:0.034:T;

% number of harmonic
N = 1000;

% Calculation coeff a_k and b_k
a_k = zeros(1, N);
b_k = zeros(1, N);
a0_2 = 0.6;

for k = 1:N
    a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
    b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
end

% Calculation A_k and phi_k
A_k = sqrt(a_k.^2 + b_k.^2);
phi_k = atan2(-b_k, a_k);
A_k_0 = a0_2/2;
% generation signal
x_generated = zeros(size(t));

% Sum of harmonic components
for k = 1:N
    x_k = a_k(k) * cos(2 * pi * k * t / T) + b_k(k) * sin(2 * pi * k * t / T);
    x_generated = x_generated + x_k;
end

x_generated = x_generated + a0_2;

x = @(t) (heaviside(t - 0.2) - heaviside(t - 0.8));
% Calculate energy using integral
Signal_Energy_time = integral(@(t) (x(t)).^2, 0, T);
Signal_Energy_phase_90 = 0.9 * Signal_Energy_time;
Signal_90_sum = A_k_0^2;
Signal_90_sum_all = A_k_0^2;
long_polosa_propuska = 0;
stem(A_k)
for k = 1:N
    if Signal_90_sum < Signal_Energy_phase_90 
        Signal_90_sum = Signal_90_sum + abs(A_k(k)).^2;
        long_polosa_propuska = k;
    end
    Signal_90_sum_all = Signal_90_sum_all + abs(A_k(k)).^2;
end
stem(1:N, A_k);

fprintf('Ширина полосы пропускания: %d\n', long_polosa_propuska);
