clearvars
clc

% i = 0:10;
% x = i*0;
% plot(x, 'r', 'LineWidth',2)
xline(0,'LineWidth',2);
hold on
title('Выражение')
ylabel('\(u(n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
xlim([-1;4])
grid on

FileName = 'Task_1.png';
print('-dpng', '-opengl','-r300',FileName);
