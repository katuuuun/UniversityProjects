clearvars
clc

% Определение функции x(t)
t1 = 0.8;
t2 = 0.2;
T = 0.6; % Изменили период на 0.6
t = 0:0.001:T;

x = @(t) (heaviside(t - t2) - heaviside(t - t1 - t2));

% Количество гармоник
N = 20;

% Расчет коэффициентов a_k и b_k
a0 = (2 / T) * integral(@(t) x(t), 0, T);
a_k = zeros(1, N);
b_k = zeros(1, N);

for k = 1:N
    a_k(k) = (2 / T) * integral(@(t) x(t) .* cos(2 * pi * k * t / T), 0, T); % Пересчитываем интегралы с новыми пределами
    b_k(k) = (2 / T) * integral(@(t) x(t) .* sin(2 * pi * k * t / T), 0, T); % Пересчитываем интегралы с новыми пределами
end


% Расчет A_k и phi_k
A_k = sqrt(a_k.^2 + b_k.^2);
phi_k = atan2(b_k, a_k);

% Восстановление сигнала x(t)
x_reconstructed = a0/2 * ones(size(t));

for k = 1:N
    x_reconstructed = x_reconstructed + A_k(k) * cos(2 * pi * k * t / T - phi_k(k));
end

% Создание графиков
figure('Position', [100, 100, 800, 600]);

subplot(3, 1, 1);
stem(1:N, A_k, 'o-');
title('Амплитуда $A_k$', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$A_k$', 'Interpreter', 'latex', 'FontSize', 14);

subplot(3, 1, 2);
stem(1:N, phi_k, 'o-');
title('Фаза $\phi_k$', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('$k$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$\phi_k$', 'Interpreter', 'latex', 'FontSize', 14);

subplot(3, 1, 3);
plot(t, x_reconstructed);
title('$x(t)$ через амплитуду и фазу', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('$t$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$x(t)$', 'Interpreter', 'latex', 'FontSize', 14);
