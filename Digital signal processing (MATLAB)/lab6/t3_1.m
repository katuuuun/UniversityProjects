clearvars
clc

% Загрузка аудиофайла
file_name = '02L3.wav';
[y, fs] = audioread(file_name);

% Параметры анализа
segment_length = 320;
overlap = 160;
num_segments = floor((length(y) - overlap) / (segment_length - overlap));
period_estimates = zeros(1, num_segments);
flag = 0;

% Изменение типа расширения для каждой секции сигнала
extension_type = 'zero'; % Начинаем с нулевого расширения

% Создаем ячейку для хранения результатов
autocorrelation_results = cell(1, num_segments);

for i = 1:num_segments
    start_idx = (i - 1) * (segment_length - overlap) + 1;
    end_idx = start_idx + segment_length - 1;
    segment = y(start_idx:end_idx);
    
    % Вычисление АКФ с текущим типом расширения
    autocorr = my_autocorrelation(segment, flag);
    
    % Нахождение номера отсчета с первым максимумом
    [~, max_idx] = max(autocorr);
    
    % Оценка периода основного тона
    period_estimates(i) = max_idx;
    
    % Сохранение результатов АКФ
    autocorrelation_results{i} = autocorr;
    
    % Переключение типа расширения (нуль -> периодический)
    flag = 1;
end

% Отображение результатов на графике
figure;
plot(1:num_segments, period_estimates);
xlabel('Номер сегмента');
ylabel('Период основного тона');
title('Оценка периода основного тона');

% Вывод среднего значения оценок периода
average_period = mean(period_estimates);
fprintf('Средний период основного тона: %.2f отсчетов\n', average_period);




