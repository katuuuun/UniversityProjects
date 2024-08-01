clearvars
clc
addpath('lib')

%% In this task, using the invariant impulse response method, it is 
% necessary to find the transfer function of a digital IIR filter obtained 
% from an analog filter with a transfer characteristic H(s) = 1/(s+1). 
% The frequency response, phase response and impulse response of this 
% filter are plotted

%% Parameters
w0 = 1;
epsilon = sqrt(10^(1/10)-1);
omega = 0:0.01:pi;
x = omega/w0;
n = 4;
ws = 3;
n_butterworth = 1;

%% Chebyshev polynomials
T = ones(n+1, length(x));
T(2, :) = x;

% Compute Chebyshev polynomials
for i = 3 : n+1
   T(i, :) = 2*x.*T(i-1, :) - T(i-2, :); 
end

%% Chebyshev filter
H = 1 ./ sqrt(1 + epsilon^2 * T(n+1,:).^2);

% Compute magnitude response in dB
magnitude_dB = 20 * log10(abs(H));

% Find the index of the frequency ws in the omega array
idx_ws = find(omega == ws);

% Magnitude response of the Chebyshev filter at ws
magnitude_ws_chebyshev = magnitude_dB(idx_ws);

%% Butterworth filter

% Magnitude response of the Butterworth filter at ws
H_butterworth = sqrt(1 ./ (1 + ( omega / w0).^(2*n_butterworth)));
magnitude_dB_But = 20 * log10(abs(H_butterworth));

% Find the minimum Butterworth filter order
while magnitude_dB_But(idx_ws) >= magnitude_ws_chebyshev
    n_butterworth = n_butterworth + 1;
    H_butterworth = sqrt(1 ./ (1 + ( omega / w0).^(2*n_butterworth)));
    magnitude_dB_But = 20 * log10(abs(H_butterworth));
end
    n_butterworth = n_butterworth - 1;
    H_butterworth_ws = sqrt(1 ./ (1 + ( omega / w0).^(2*n_butterworth)));
    magnitude_dB_But = 20 * log10(abs(H_butterworth_ws));
    
%% Output
disp(['The max order of the Butterworth filter at ws = 3 is: ', num2str(n_butterworth)]);
figure;
hold on;
plot(omega, magnitude_dB);
plot(omega, magnitude_dB_But);
title('Chebyshev Filter and Butterworth Filter',...
    'Interpreter','latex','FontSize', 16);
legend('Chebyshev', 'Butterworth',...
    'Interpreter','latex','FontSize', 16);
xlabel('Frequency', 'Interpreter','latex','FontSize', 16);
ylabel('Magnitude, dB', 'Interpreter','latex','FontSize', 16);
ylim([-60, 0]);
grid on;

FileName = 'pic/Task_3.png';
print('-dpng', '-opengl', '-r300', FileName);