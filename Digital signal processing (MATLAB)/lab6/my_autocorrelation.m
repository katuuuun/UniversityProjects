% Создайте функцию для вычисления АКФ с учетом типа расширения сигнала
function autocorrelation = my_autocorrelation(signal, flag)
    N = length(signal);
%     autocorrelation = zeros(1, 2 * N - 1); % Создайте массив для хранения результатов

    if flag == 0
        for k = -N+1:N-1 % Измените диапазон смещений
            autocorrelation(k+N) = sum(signal(max(1, 1-k):min(N, N-k)) .* signal(max(1, 1+k):min(N, N+k)));
        end
    elseif flag == 1
        extended_signal = [signal, signal(1:N - 1)];
        for k = -N+1:N-1 % Измените диапазон смещений
            autocorrelation(k+N) = sum(extended_signal(1:N) .* extended_signal(mod(k:N-1, N)+1));
        end
    else
        error('Неподдерживаемый тип расширения сигнала');
    end
    
    % Обрежьте результат до правильного размера
    autocorrelation = autocorrelation(1:N);
end
