function [autocorr] = AKF_function(signal, flag)
    N = length(signal);
    autocorr = zeros(1, N);
    
    if flag == 0
         for lag = 1:N
             autocorr(lag) = sum(signal(1:N-lag+1) .* signal(lag:N));
         end
    elseif flag ~=0
        extr_signal = [signal, signal];
        for i = 1:N
            autocorr(i) = sum(extr_signal(1:N) .* extr_signal(i+1:N+i));
        end
    end
end
