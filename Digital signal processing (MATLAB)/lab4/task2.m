clearvars
clc
addpath('lib')

%% In this task, using the Chebyshev polynomial, it is necessary to 
% construct the frequency response of the filter on a logarithmic scale 
% with w0 = 1 and epsilon such that the filter unevenness in the passband 
% is equal to 1 dB(We use formula ϵ= sqrt(10^(A_{dB}/10)-1)).

%% Parameters
w0 = 1;
epsilon = sqrt(10^(1/10)-1);
omega = 0:0.01:pi;
x = omega/w0;
n = 4;

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

%% Output
figure;
hold on;
plot(omega, magnitude_dB);
title('Chebyshev Filter', 'Interpreter','latex','FontSize', 16);
xlabel('Frequency', 'Interpreter','latex','FontSize', 16);
ylabel('Magnitude, dB', 'Interpreter','latex','FontSize', 16);
ylim([-50, 0]);
grid on;

FileName = 'pic/Task_2.png';
print('-dpng', '-opengl', '-r300', FileName);