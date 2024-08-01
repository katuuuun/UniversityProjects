clearvars
clc

% signal parametrs
fc = 0.5;
fm = 20;

syms t ;    % symbolic variables  
x_t = sin(2*pi*fc.*t).*sin(2*pi*fm.*t)*(heaviside(t) - heaviside(t - 10)); %generate signal

%plot signal
figure( 'Position',[100 100 800 300])
fplot(x_t, [0, 10], 'LineWidth',2)
hold on
title('Signal')
ylabel('\(x(t)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(t\)', 'Interpreter','latex','FontSize', 16)
grid on

FileName = 'Task_1.png';
print('-dpng', '-opengl','-r300',FileName);