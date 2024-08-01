clearvars
clc

% impuls options
N = 64;
x_impuls = zeros(1, N);
x_impuls(1) = 1;
b = [0, 1];
a = [1, 0, 0.1, -0.1];
y = filter(b, a, x_impuls);
 
% graph output
subplot(2, 1, 1);
hold on
stem(0:N-1, x_impuls, 'b', 'LineWidth', 1.5);
title('Импульсный входной сигнал x(n)', 'FontSize', 14);
xlabel('n', 'Interpreter','latex','FontSize', 14);
ylabel('Амплитуда','FontSize', 14);
grid on

subplot(2, 1, 2);
hold on
stem(0:N-1, y, 'r', 'LineWidth', 1.5);
title('Импульсный выходной сигнал y(n)', 'FontSize', 14);
xlabel('n', 'Interpreter','latex','FontSize', 14);
ylabel('Амплитуда', 'FontSize', 14);
grid on


FileName = 'Task_5.png';
print('-dpng', '-opengl','-r300',FileName);