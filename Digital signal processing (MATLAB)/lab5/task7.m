clearvars
clc

w1 = pi/6;
w2 = pi/9;
a = 1.15;
b = 0.9;

n = 0:25;
x1_n = sin(w1*n);
n = -15:25;
x2_n = cos(w1*n);
n = -20:0;
x3_n = a.^n.*sin(w2*n);
n =  0:50;
x4_n = b.^n.*cos(w2*n);
figure( 'Position',[100 100 500 500])
subplot(4,1,1);
plot(x1_n, 'r', 'LineWidth',2)
hold on
ylabel('\(\sin(w_1n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(4,1,2);
plot(x2_n, 'b', 'LineWidth',2)
hold on
ylabel('\(\cos(w_1n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(4,1,3);
plot(x3_n, 'g', 'LineWidth',2)
hold on
ylabel('\(a^n\sin(w_2n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(4,1,4);
plot(x4_n, 'm', 'LineWidth',2)
hold on
ylabel('\(a^n\cos(w_2n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
title('Дискретный синусоидальный сигнал')
grid on