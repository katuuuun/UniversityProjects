clearvars
clc
addpath('lib')

%% This task builds an IIR filter described by the equation
% y(n) = alpha*y(n-1) +x(n)*(1-alpha).
% When a single step was applied to it, the filter output reached a value 
% of 0.9 in a time equal to 150 sampling intervals.

%% Parametrs
alpha = 0.1^(1/150);
n_samples = 150; 
x = ones(1, n_samples); 
y = zeros(size(x));

%% Creating filter and useing u(n)
y(1) = (1 - alpha);
for n = 2:numel(x)
    y(n) = alpha * y(n-1) + x(n) * (1 - alpha);
end

%% Output
figure;
hold on;
subplot(2,1,1);
stem(0:numel(x)-1, x);
title('Input signal', 'Interpreter','latex','FontSize', 16);
xlabel('n', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
grid on;

hold on;
subplot(2,1,2);
stem(0:numel(y)-1, y);
title('Output signal', 'Interpreter','latex','FontSize', 16);
xlabel('n', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
grid on;

FileName = 'pic/Task_6.png';
print('-dpng', '-opengl', '-r300', FileName);