clearvars
clc

fcut = 4;
wc = 2*pi/fcut; % freq cut
n=4; % filter order

[zb,pb,kb] = butter(n, wc, "s");

syms s Hs_matr w
s = 1j*w;

Hs_matr = kb/((s-pb(1))*(s-pb(2))*(s-pb(3))*(s-pb(4)))
ht_matr = ifourier(Hs_matr, w)


figure;
fplot(ht_matr, [0, 10], 'b-', 'LineWidth', 1.5)
grid on;
xlabel('$t$', 'Interpreter', 'latex');
ylabel('$h(t)$', 'Interpreter', 'latex');
title('Impulse response of a 4th order Butterworth filter');

FileName = 'Task_5.png';
print('-dpng', '-opengl','-r300',FileName);





% % Определение параметров фильтра
% fcut = 4;
% wc = 2*pi/fcut;      % Частота среза, рад/с
% n = 4;               % Порядок фильтра
% 
% % Расчет коэффициентов фильтра
% [num, den] = butter(n, wc, 's');
% 
% % Определение времени для построения временной характеристики
% t = linspace(0, 10, 1000);
% 
% % H=freqs(num,den,2*pi*linspace(-10, 10, 1000));
% H=freqs(num,den,2*pi*t);
% % Временная характеристика фильтра Баттерворта
% h_t = ifft(H);
% 
% % Построение графика
% figure;
% plot(t, real(h_t), 'k', 'LineWidth', 1.5);
% grid on;
% xlabel('$t$', 'Interpreter', 'latex');
% ylabel('$h(t)$', 'Interpreter', 'latex');
% title('Импульсная характеристика фильтра Баттерворта 4-го порядка');