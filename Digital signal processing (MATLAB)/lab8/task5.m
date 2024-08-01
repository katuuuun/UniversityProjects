clearvars
clc

% function x(t)
t1 = 0.2;
t2 = 0.8;
T = 1; 
t = 0:0.001:T;

% number of harmonic
N = 200;

% Calculation coeff a_k and b_k
a_k = zeros(1, N);
b_k = zeros(1, N);

for k = 1:N
    a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
    b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
end

% Calculation A_k and phi_k
A_k = sqrt(a_k.^2 + b_k.^2);
phi_k = atan2(-b_k, a_k);

% Add a_0 to A_k and phi_k
a0 = 0.6;
A_k = [a0, A_k];
phi_k = [0, phi_k];

% output amplitude and phase
figure('Position', [100, 100, 600, 300]);
subplot(2, 1, 1);
stem(0:N, A_k);
title('Amplitude', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$A_k$', 'Interpreter', 'latex', 'FontSize', 14);
subplot(2, 1, 2);
stem(0:N, phi_k);
title('Phase', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\phi_k$', 'Interpreter', 'latex', 'FontSize', 14);

FileName = 'Task_5.png';
print('-dpng', '-opengl', '-r300', FileName);
