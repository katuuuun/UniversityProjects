function [Spec_log, Spec_line] = spectrogram_log_linear(x, L, N)
%% This function creates a spectrogram for the input signal with the 
% required Hann window parametrs. A spectrogram is output on linear and
% logorithmic scale.

%% Parameters
w = hann(N); % Hann windows function
Ln = length(x);

N_frames = floor((Ln - N) / L); % Number of frames
N_bins = round(N / 2) + 1; % numbers of effecrive frequency bins
Spec_log = zeros(N_bins, N_frames); 
Spec_line = zeros(N_bins, N_frames);

%% Creates a spectrogram in 2 type of scale
for l = 1 : N_frames
    fprintf('Frame %d of %d\n', l, N_frames);
    x_frame = x(1 + (l - 1) * L : (l - 1) * L + N); % frame parameters
    x_frame = x_frame .*w;     % frame * analysis window

    X_kl = fft(x_frame);    % FFT for this frame
    X_kl = X_kl(1 : N_bins) / (N / 2); % Selecting the symmetrical part of the FFT of frames
    Spec_log(:, l) = 20 * log10(abs(X_kl)); % write spectrogram in logorithmic scale
    Spec_line(:, l) = abs(X_kl); % write spectrogram in linear scale
end
end

