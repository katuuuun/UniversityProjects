clearvars
clc

N = 8*2;
f = 1/N;
fs= 1;
n = 0:1:31;
z= sin(2*pi*f/fs*n);
figure( 'Position',[100 100 500 200])
hold on
ylabel('\(\sin(2\pi\frac{F}{Fs}n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
plot(z, 'r', 'LineWidth',2)
stem(z,'LineWidth',1.5);
legend('\(\sin(2\pi\frac{F}{Fs}n)\)','Interpreter','latex','FontSize', 16);
title('Дискретный синусоидальный сигнал')
xlim([0,32])
grid on
