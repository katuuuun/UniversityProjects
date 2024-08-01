clearvars
clc
addpath('lib')

%% This task searches for frequencies for a certain frequency response 
% value and passes the exponential signal through an FIR filter

%% Parametrs
w = linspace(0, 2*pi, 500);
H = 0.9 + 0.05*(exp(-10*1j*w) - exp(-15*1j*w));
abs_H = abs(H);
w_index = find(abs(abs_H - 0.95) < 0.01);
wh = w(w_index(1));
n = 0:100;
x = exp(1j * wh .* n);

%% FIR filter
a = [1];
b = [0.9 0 0 0 0 0 0 0 0 0 0.05 0 0 0 0 -0.05];
y = filter(b, a, x);

%% Output
figure('Position', [300 200 800 700]);
subplot(4,1,1);
hold on;
plot(n, real(x));
ylim([-1.2 1.2]);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
xlabel('$n$', 'Interpreter','latex','FontSize', 16);
title('$Re(x)$', 'Interpreter','latex','FontSize', 16);
grid on;

subplot(4,1,2);
hold on;
plot(n, real(y));
ylim([-1.2 1.2]);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
xlabel('$n$', 'Interpreter','latex','FontSize', 16);
title('$Re(y)$', 'Interpreter','latex','FontSize', 16);
grid on;

subplot(4,1,3);
hold on;
stem(n, imag(x));
ylim([-1.2 1.2]);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
xlabel('$n$', 'Interpreter','latex','FontSize', 16);
title('$Im(x)$', 'Interpreter','latex','FontSize', 16);
grid on;

subplot(4,1,4);
hold on;
stem(n, imag(y));
ylim([-1.2 1.2]);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
xlabel('$n$', 'Interpreter','latex','FontSize', 16);
title('$Im(y)$', 'Interpreter','latex','FontSize', 16);
grid on;

FileName = 'pic/Task_2.png';
print('-dpng', '-opengl', '-r300', FileName);