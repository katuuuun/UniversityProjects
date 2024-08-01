clearvars
clc

% impuls options
N = 64;
x_impuls = zeros(1, N);
y_impuls = zeros(1, N);
x_impuls(1) = 1;

% sistem options
N = 64; 
x = zeros(1, N); % input signal
y = zeros(1, N); % output signal

for n = 2:N
    x(n) = randn(); % generation random imput signal
end

% output signal
for n = 4:N
    y(n) = x(n-1) - 0.1 * y(n-2) + 0.1 * y(n-3);
end

for n = 2:N
    if n >= 4
        y_impuls(n) = x_impuls(n-1) - 0.1 * y_impuls(n-2) + 0.1 * y_impuls(n-3);
    elseif n == 2 
        y_impuls(n) = x_impuls(n-1);
    elseif n == 3 
        y_impuls(n) = x_impuls(n-1) - 0.1 * y_impuls(n-2);
    end
end

% graph output
subplot(4, 1, 1);
hold on
stem(1:N, x, 'b', 'LineWidth', 1.5);
title('Входной сигнал x(n)');
xlabel('n');
ylabel('Амплитуда');
grid on

subplot(4, 1, 2);
hold on
stem(1:N, y, 'r', 'LineWidth', 1.5);
title('Выходной сигнал y(n)');
xlabel('n');
ylabel('Амплитуда');
grid on

subplot(4, 1, 3);
hold on
stem(1:N, x_impuls, 'b', 'LineWidth', 1.5);
title('Импульсный входной сигнал x(n)');
xlabel('n');
ylabel('Амплитуда');
grid on

subplot(4, 1, 4);
hold on
stem(1:N, y_impuls, 'r', 'LineWidth', 1.5);
title('Импульсный выходной сигнал y(n)');
xlabel('n');
ylabel('Амплитуда');
grid on

FileName = 'Task_4.png';
print('-dpng', '-opengl','-r300',FileName);