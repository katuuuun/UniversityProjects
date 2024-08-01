function [x_reconstructed] = reconstructed_with_base_freq(x_segment, threshold)
%% This function takes a frequency selection threshold and a signal,
% which needs to be compared with the threshold. As a result, the 
% function produces a reconstructed signal using only those frequencies 
% that satisfy the criterion: |X(k)|^2/P_x > threshold.


%% Determine the main frequency components of the signal
X_segment = fft(x_segment); % FFT for this segment
power = sum(abs(X_segment).^2); % total signal power

base_freq_indices = find((abs(X_segment).^2 / power) > threshold); % base frequencies indices

%% Reconstruct a signal in the time scale using only the base frequencies
X_reconstructed = zeros(size(X_segment));
X_reconstructed(base_freq_indices) = X_segment(base_freq_indices);
x_reconstructed = ifft(X_reconstructed);
end

