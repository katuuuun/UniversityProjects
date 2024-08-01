clearvars
clc

f = pi;
fs= 100;
n = 0:1:31;
z= sin(2*pi*f/fs*n);
figure( 'Position',[100 100 500 200])
hold on
ylabel('\(\sin(2\pi\frac{F}{Fs}n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
stem(z,'LineWidth',1.5);
plot(z, 'r', 'LineWidth',2)
legend('\(\sin(2\pi\frac{F}{Fs}n)\)','Interpreter','latex','FontSize', 16);
title('Дискретный непериодический синусоидальный сигнал')
xlim([0,32])
grid on
