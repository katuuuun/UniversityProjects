clearvars
clc

% impuls options
N = 64;
x_impuls = zeros(1, N);
x_impuls(1) = 1;
b = [0, 1];
a = [1];
y = filter(b, a, x_impuls);
 
% graph output
subplot(4, 1, 1);
hold on
stem(0:N-1, x_impuls, 'b', 'LineWidth', 1.5);
title('Импульсный входной сигнал x(n)', 'FontSize', 14);
xlabel('n', 'Interpreter','latex','FontSize', 14);
ylabel('Амплитуда','FontSize', 14);
grid on

subplot(4, 1, 2);
hold on
stem(0:N-1, y, 'r', 'LineWidth', 1.5);
title('Импульсный выходной сигнал y(n)', 'FontSize', 14);
xlabel('n', 'Interpreter','latex','FontSize', 14);
ylabel('Амплитуда', 'FontSize', 14);
grid on

for n = 2:N
    y(n) = n^2*x_impuls(n-1);
end
subplot(4, 1, 3);
hold on
stem(0:N-1, y, 'r', 'LineWidth', 1.5);
title('Импульсный выходной сигнал y(n)', 'FontSize', 14);
xlabel('n', 'Interpreter','latex','FontSize', 14);
ylabel('Амплитуда', 'FontSize', 14);
grid on
k1 = -5;
k2 = 5;

for n = 2:N
    if (n >= 6) 
            for k = k1 : k2
                if (n-k) <= N && ((n-k)>0)
                    y(n) = sum(x_impuls(n-k));
                end
            end

    elseif (n == 5) 
            for k = k1+1 : k2
                if (n-k) <= N && ((n-k)>0)
                    y(n) = sum(x_impuls(n-k));
                end
            end
    elseif (n == 4) 
            for k = k1+2 : k2
                if (n-k) <= N && ((n-k)>0)
                    y(n) = sum(x_impuls(n-k));
                end
            end
    elseif (n == 3) 
            for k = k1+3 : k2
                if (n-k) <= N && ((n-k)>0)
                    y(n) = sum(x_impuls(n-k));
                end
            end
     elseif (n == 2) 
            for k = k1+4 : k2
                if ((n-k) <= N) && ((n-k)>0)
                    y(n) = sum(x_impuls(n-k));
                end
            end
    end
end
subplot(4, 1, 4);
hold on
stem(0:N-1, y, 'r', 'LineWidth', 1.5);
title('Импульсный выходной сигнал y(n)', 'FontSize', 14);
xlabel('n', 'Interpreter','latex','FontSize', 14);
ylabel('Амплитуда', 'FontSize', 14);
grid on

FileName = 'Task_dop7.png';
print('-dpng', '-opengl','-r300',FileName);