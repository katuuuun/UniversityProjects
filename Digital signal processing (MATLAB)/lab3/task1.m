clearvars
clc
addpath('lib')

%% In this task, the frequency response of the FIR filter is derived in 
% accordance with the equation:
% y(n) = 0.9x(n) + 0.05x(n-10) - 0.05x(n-15);

%% Parametrs
w = linspace(0, 2*pi, 500);
H = 0.9 + 0.05*(exp(-10*1j*w) - exp(-15*1j*w));

%% Output
figure;
plot(w, abs(H));
hold on
xlabel('$\omega$', 'Interpreter','latex','FontSize', 16);
ylabel('$|H(e^{jw})|$', 'Interpreter','latex','FontSize', 16);
title('AFC FIR-filter', 'Interpreter','latex','FontSize', 16);
grid on;

FileName = 'pic/Task_1.png';
print('-dpng', '-opengl', '-r300', FileName);