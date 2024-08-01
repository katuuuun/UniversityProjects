clearvars
clc

% function x(t)
t1 = 0.2;
t2 = 0.8;
T = 1; 
t = 0:0.001:T; 
x = @(t) (heaviside(t - t1) - heaviside(t - t2));

% number of harmonic
N = 30;
n = [1, 3, 10, 30];
n_E = (1:30);

% Calculation coeff a_k and b_k
a_k = zeros(1, N);
b_k = zeros(1, N);
a0_2 = 0.6;

x_generated1 = zeros(size(t));
x_generated3 = zeros(size(t));
x_generated10 = zeros(size(t));
x_generated30 = zeros(size(t));

% generation signal with 1, 3, 10, 30 harmonics
for i = 1 : length(n)
    x_generated_0 = zeros(size(t));
    for k = 1:n(i)
        a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
        b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
        x_k = a_k(k) * cos(2 * pi * k * t / T) + b_k(k) * sin(2 * pi * k * t / T);
        x_generated_0 = x_generated_0 + x_k;
    end
    if i == 1
        x_generated1 = x_generated_0 + a0_2;
    elseif i == 2
        x_generated3 = x_generated_0 + a0_2;
    elseif i == 3
        x_generated10 = x_generated_0 + a0_2;  
    elseif i == 4
        x_generated30 = x_generated_0 + a0_2;
    end
end

epsilon1 = abs(x(t) - x_generated1);
epsilon3 = abs(x(t) - x_generated3);
epsilon10 = abs(x(t) - x_generated10);
epsilon30 = abs(x(t) - x_generated30);

% otput signal epsilon
figure('Position',[100 100 800 450])
subplot(4, 2, 1);
plot(t, epsilon1);
title('\(\epsilon_1\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(\epsilon(t)\)','Interpreter','latex', 'FontSize', 14);

subplot(4, 2, 3);
plot(t, epsilon3);
title('\(\epsilon_3\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(\epsilon(t)\)','Interpreter','latex', 'FontSize', 14);

subplot(4, 2, 5);
plot(t, epsilon10);
title('\(\epsilon_{10}\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(\epsilon(t)\)','Interpreter','latex', 'FontSize', 14);

subplot(4, 2, 7);
plot(t, epsilon30);
title('\(\epsilon_{30}\)','Interpreter','latex', 'FontSize', 14);
xlabel('t','Interpreter','latex', 'FontSize', 14);
ylabel('\(\epsilon(t)\)','Interpreter','latex', 'FontSize', 14);

% calculation power error signal
for i = 1 : 30
    x_generated = zeros(size(t));
    for k = 1 : n_E(i)
        a_k(k) = 1/(pi*k) * (sin(2*pi*k*t2) - sin(2*pi*k*t1));
        b_k(k) = 1/(pi*k) * (cos(2*pi*k*t2) - cos(2*pi*k*t1));
        x_k = a_k(k) * cos(2 * pi * k * t / T) + b_k(k) * sin(2 * pi * k * t / T);
        x_generated = x_generated + x_k;
        if k == n_E(i);
            x_generated = x_generated + a0_2;
            epsilon = abs(x(t) - x_generated);
        end
    end
    E(i) = sum(epsilon.^2);
end

% output power error signal
subplot(4, 2, [2,4,6,8])
plot(E);
title('\(E_n\)','Interpreter','latex', 'FontSize', 14);
xlabel('n','Interpreter','latex', 'FontSize', 14);
ylabel('\(E_n\)','Interpreter','latex', 'FontSize', 14);
FileName = 'Task_4.png';
print('-dpng', '-opengl','-r300',FileName);
