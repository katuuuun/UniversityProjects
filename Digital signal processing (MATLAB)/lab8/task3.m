clearvars
clc

% function x(t)
t1 = 0.2;
t2 = 0.8;
T = 1; 
t = -T:0.001:2*T; 

% number of harmonic
N = 30;
n = [1, 3, 10, 30];

% Calculation coeff a_k and b_k
a_k = zeros(1, N);
b_k = zeros(1, N);

% zero generation signal
x_generated = zeros(size(t));
x_generated1 = zeros(size(t));
x_generated3 = zeros(size(t));
x_generated10 = zeros(size(t));
x_generated30 = zeros(size(t));
a0_2 = 0.6;

% generation signal with 1, 3, 10, 30 harmonics
for k = 1:n(1)
    a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
    b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
    x_k = a_k(k) * cos(2 * pi * k * t / T) + b_k(k) * sin(2 * pi * k * t / T);
    x_generated1 = x_generated1 + x_k;
end
x_generated1 = x_generated1 + a0_2;

for k = 1:n(2)
    a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
    b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
    x_k = a_k(k) * cos(2 * pi * k * t / T) + b_k(k) * sin(2 * pi * k * t / T);
    x_generated3 = x_generated3 + x_k;
end
x_generated3 = x_generated3 + a0_2;

for k = 1:n(3)
    a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
    b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
    x_k = a_k(k) * cos(2 * pi * k * t / T) + b_k(k) * sin(2 * pi * k * t / T);
    x_generated10 = x_generated10 + x_k;
end
x_generated10 = x_generated10 + a0_2;

for k = 1:n(4)
    a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
    b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
    x_k = a_k(k) * cos(2 * pi * k * t / T) + b_k(k) * sin(2 * pi * k * t / T);
    x_generated30 = x_generated30 + x_k;
end
x_generated30 = x_generated30 + a0_2;

% otput signal
figure('Position',[100 100 600 500])
subplot(4, 1, 1);
plot(t, x_generated1);
title('\(S_1\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(S_1(t)\)','Interpreter','latex', 'FontSize', 14);

subplot(4, 1, 2);
plot(t, x_generated3);
title('\(S_3\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(S_3(t)\)','Interpreter','latex', 'FontSize', 14);

subplot(4, 1, 3);
plot(t, x_generated10);
title('\(S_{10}\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(S_{10}(t)\)','Interpreter','latex', 'FontSize', 14);

subplot(4, 1, 4);
plot(t, x_generated30);
title('\(S_{30}\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(S_{30}(t)\)','Interpreter','latex', 'FontSize', 14);

FileName = 'Task_3.png';
print('-dpng', '-opengl','-r300',FileName);

% we see the gibs effect