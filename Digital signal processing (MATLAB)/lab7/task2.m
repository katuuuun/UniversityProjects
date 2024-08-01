clearvars
clc

mu = 255;
n_0 = 0;
n = -1:99;
% base signal
for i = 1:length(n)
    sign_resl(i) = sign_function(n(i));
end 
y_n = sign_resl.*(log10(1 + mu*abs(n))/log10(1+mu));
figure(1);
hold on
subplot(5,1,5);
% plot(y_n);
grid on
title('Исходный сигнал');

% delta impuls
for i = 1: length(n)
    n(i) = n(i) - n_0;
    x_n(i) = delta_fun(n(i));
end
for i = 1:length(x_n)
    sign_resl(i) = sign_function(x_n(i));
end 
y_n = sign_resl.*(log10(1 + mu*abs(x_n))/log10(1+mu));
hold on
subplot(5,1,1);
stem(y_n);
grid on
title('Реакция на дельта-импульс');

% unit_step
for i = 1: length(n)
    n(i) = n(i) - n_0;
    x_n(i) = unit_step(n(i));
end
for i = 1:length(x_n)
    sign_resl(i) = sign_function(x_n(i));
end 
y_n = sign_resl.*(log10(1 + mu*abs(x_n))/log10(1+mu));
figure(1);
hold on
subplot(5,1,2);
stem(y_n);
grid on
title('Реакция на единичную ступеньку');

% low frequency signal
x_n = cos(2*pi*0.01*n);
for i = 1:length(x_n)
    sign_resl(i) = sign_function(x_n(i));
end 
y_n = sign_resl.*(log10(1 + mu*abs(x_n))/log10(1+mu));
figure(1);
hold on
subplot(5,1,3);
stem(y_n);
grid on
title('Реакция на низкочастотный синусоидальный сигнал');

% hight frequency signal
x_n = cos(2*pi*0.48*n);
for i = 1:length(x_n)
    sign_resl(i) = sign_function(x_n(i));
end 
y_n = sign_resl.*(log10(1 + mu*abs(x_n))/log10(1+mu));
figure(1);
hold on
subplot(5,1,4);
stem(y_n);
grid on
title('Реакция на высокочастотный синусоидальный сигнал');


FileName = 'Task_1.png';
print('-dpng', '-opengl','-r300',FileName);