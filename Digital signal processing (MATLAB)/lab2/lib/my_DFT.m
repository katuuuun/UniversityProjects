function X = my_DFT(x)
%% This function performs a Discrete Fourier Transform according to the 
% synthesis formula, but without using the exponent. The exponent was 
% calculated using Euler's formula
% exp(-1j * 2*pi*k(i)*n/N) = cos(2 * pi * k(i) * n / N)) - 1j * sin(2 * pi * k(i) * n / N)); 
%% parametrs
    N = length(x);  % sum limit
    n = 0:N-1;      % sum limit
    k = 0:N-1;      % leng fourier 
    X = zeros(size(k));
    
%% synthesis formula
    for i = 1:length(k) % exp(-1j * 2*pi*k(i)*n/N) = cos(2 * pi * k(i) * n / N)) - 1j * sin(2 * pi * k(i) * n / N)); 
        X_real = sum(x .* cos(2 * pi * k(i) * n / N));  
        X_imag = sum(x .* sin(2 * pi * k(i) * n / N));
        X(i) = X_real - 1j * X_imag;
    end
end
