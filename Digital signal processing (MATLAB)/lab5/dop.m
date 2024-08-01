clearvars
clc

fs = 16000;
fam = 2;
fm = 440;
ka = 0.05;
duration = 2;
t = 0:1/fs:duration-1/fs;
r = 0.4;

for i = 1:length(t)
    alpha = 2 * pi * fm * t(i);
    if alpha < (2*pi/(1 + r))
        Sba(i) = 0.5 * (1 - cos((1 + r) / 2 * alpha));
    else
        Sba(i) = 0.5 * (1 - cos((1 + r) / (2 * r) * alpha + ((r - 1) / r) * pi));
    end
end

% Генерация AM сигнала
Sam = Sba .* (1 + ka * cos(2 * pi * fam * t));

% Визуализация
subplot(2,1,1);
plot(t, Sam);
grid on;
xlabel('Время (сек)');
ylabel('Амплитуда');
title('Ak ~= 0');

% Сохранение в файл
audiowrite('am_skew_sin.wav', Sam', fs);

% Генерация AM сигнала при ka = 0
 ka = 0;
 Sam = Sba .* (1 + ka * cos(2 * pi * fam * t));
 subplot(2,1,2);
 hold on
 plot(Sba);
 grid on
 title('Ak = 0');
 
% Сохранение в файл
audiowrite('am_skew_sin0.wav', Sam', fs);