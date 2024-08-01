clearvars
clc

mu = 255;
x_n = -1:0.1:1;
for i = 1:length(x_n)
    sign_resl(i) = sign_function(x_n(i));
     delta(i) =  delta_fun(i-1);
%     unit(i) = unit_step(i-1);
end 
low_x = cos(2*pi*0.01*x_n);
high_x = cos(2*pi*0.48*x_n);
for i = 1:length(x_n)
    sign_resl1(i) = sign_function(delta(i));
    sign_resl2(i) = sign_function(unit(i));
    sign_resl3(i) = sign_function(low_x(i));
    sign_resl4(i) = sign_function(high_x(i));
end 

y_n = sign_resl.*(log10(1 + mu*abs(x_n))/log10(1+mu));
y_n1 = sign_resl1.*(log10(1 + mu*abs(delta))/log10(1+mu));
y_n2 = sign_resl2.*(log10(1 + mu*abs(unit))/log10(1+mu));
y_n3 = sign_resl3.*(log10(1 + mu*abs(low_x))/log10(1+mu));
y_n4 = sign_resl4.*(log10(1 + mu*abs(high_x))/log10(1+mu));
figure(1)
subplot(5, 1, 1);
hold on
plot(y_n);
grid on
title('Исходный сигнал');
subplot(5, 1, 2);
hold on
plot(y_n1);
grid on
title('Реакция на дельта-импульс');
subplot(5, 1, 3);
hold on
plot(y_n2);
grid on
title('Реакция на единичную ступеньку');
subplot(5, 1, 4);
hold on
plot(y_n3);
grid on
title('Реакция на низкочастотный синусоидальный сигнал');
subplot(5, 1, 5);
hold on
plot(y_n4);
grid on
title('Реакция на высокочастотный синусоидальный сигнал');

FileName = 'Task_1.png';
print('-dpng', '-opengl','-r300',FileName);