clearvars
clc
addpath('lib')

%% This task uses the Hannah window to calculate a two-band FIR filter 
% with a linear phase response. And takes into account transmission 
% coefficients. It also builds an ideal frequency response.

%% Parametrs
N = 49;
w1 = [0.3 0.4];
w2 = [0.8 1.0];
coeff_1_polosa = 1.5;
coeff_2_polosa = 0.3;
f = 0:0.001:1;

%% Two-band FIR filter
[b1, ~] = fir1(N, [0.3 0.4], 'bandpass', hann(N+1));
[b2, ~] = fir1(N, [0.8 0.9999999], 'bandpass', hann(N+1));
b1 = coeff_1_polosa * b1;
b2 = coeff_2_polosa * b2;

[H1, ~] = freqz(b1, 1, f*pi);
[H2, w] = freqz(b2, 1, f*pi);
H = H1 + H2;

%% Сreating an ideal frequency response
H_ideal = (f >= w1(1) & f <= w1(2)) * coeff_1_polosa + (f >= w2(1) & f <= w2(2)) * coeff_2_polosa;

%% Output
figure;
hold on
plot(f, H_ideal, 'b', 'LineWidth', 2);
plot(w/pi, abs(H), 'r--', 'LineWidth', 2);
xlabel('Normalized Frequency $\pi rad/sample$', 'Interpreter','latex','FontSize', 16);
ylabel('Magnitude', 'Interpreter','latex','FontSize', 16);
title('Frequency Response', 'Interpreter','latex','FontSize', 16);
legend('Ideal', 'Designed', 'Interpreter','latex','FontSize', 16);
grid on

FileName = 'pic/Task_5.png';
print('-dpng', '-opengl', '-r300', FileName);