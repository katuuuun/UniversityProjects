function [x_v,x_u] = vu_separate(signal, N, threshold)
%vu_separate is function for separation vocal part from unvocal of signal

% Signal strength in range
    for n = 1:length(signal)
        start = max(1, n - N + 1);
        P(n) = 10 * log10(sum(signal(start:n).^2) / N);
    end
    
    U_n = P > threshold; % vocalization sign
    
    % signal separation
    x_v = signal .* (U_n)';
    x_u = signal .* (1-U_n)';
end

