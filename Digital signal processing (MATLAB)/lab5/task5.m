clearvars
clc

t_0 = 2.95;
t_1 = 3;
f_0 = 1000;
phi_0 = pi/6;
f_s = 2000;
A = 10;
t = t_0:1/f_s:t_1;

s = continuous_sin(A, f_0, f_s, t_0, t_1, phi_0);
figure( )
hold on
ylabel('\(\sin(2\pi\frac{f}{f_s}n + \varphi_0)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(t\)', 'Interpreter','latex','FontSize', 16)
% stem(t,s, 'LineWidth',1);
plot(t, s, 'r', 'LineWidth',1)
title('Формирование синусоиды ')
grid on