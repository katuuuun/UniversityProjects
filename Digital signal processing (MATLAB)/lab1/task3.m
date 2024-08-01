clearvars
clc

% Signal parameters
fc = 0.5;
fm = 20;
t = 0:0.001:10;

% Signal
x_t = sin(2*pi*fc.*t).*sin(2*pi*fm.*t).*(heaviside(t - 0) - heaviside(t-10));

% Fourier transform
X_F = fft(x_t);

% filter parametrs
[M, N] = size(t);
Signal_Energy_sum = 0;
Signal_Energy_sum1 = 0;
Signal_Energy = 0;
X_F_abs = abs(X_F);

% Energy of signal
for k = 1:N
    Signal_Energy = Signal_Energy + abs(X_F(k)).^2;
end

% 90% of energy
Signal_Energy_90 = Signal_Energy * 0.9;

% Number of frequencies
for k = 1:N
    Signal_Energy_sum = Signal_Energy_sum + abs(X_F(k)).^2;
    if Signal_Energy_sum <= Signal_Energy_90 
         Signal_Energy_sum1 = Signal_Energy_sum1 + abs(X_F(k)).^2;
        long_polosa_propuska = k;
    end
end


% Filter out non-selected frequencies
X_F_filtered = zeros(size(X_F));
X_F_filtered(1:long_polosa_propuska) = X_F(1:long_polosa_propuska);
 
% Inverse Fourier transform to reconstruct the signal
x_t_reconstructed = ifft(X_F_filtered);

% Plot original and reconstructed signals
figure;
subplot(2,1,1);
plot(t, x_t);
title('Original Signal');

subplot(2,1,2);
plot(t, real(x_t_reconstructed));
title('Reconstructed Signal using Selected Frequencies');

FileName = 'Task_3.png';
print('-dpng', '-opengl','-r300',FileName);