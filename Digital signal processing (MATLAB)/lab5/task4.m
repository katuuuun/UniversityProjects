clearvars
clc

n_0 = 2;
n = -10:1:10;
n = n - n_0;
% for i = 1: length(n)
%     n(i) = n(i) - n_0;
%     delta(i) = delta_fun(n(i));
%     unit(i) = unit_step(n(i));
% end
delta = delta_fun(n);
unit = unit_step(n);

figure( 'Position',[100 100 500 400])
subplot(2,1,1);
hold on
ylabel('\(\delta(n-n_0)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
stem(delta,'LineWidth',1.5);
legend('\(\delta(n-n_0)\)','Interpreter','latex','FontSize', 16);
title('Единичный импульс')
xlim([0,21])
grid on
 
subplot(2,1,2);
hold on
ylabel('\(u(n-n_0)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
stem(unit,'LineWidth',1.5);
legend('\(u(n-n_0)\)','Interpreter','latex','FontSize', 16);
title('Единичный скачек')
xlim([0,21])
grid on