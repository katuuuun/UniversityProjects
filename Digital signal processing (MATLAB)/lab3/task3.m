clearvars
clc
addpath('lib')

%% This task design a lowpass FIR filter with normalized cut-off frequency at
% 0.4 and determine its frequency response.

%% Parametrs
N = 19;
wc = 0.4;        % fcut

%% FIR filter 
h = fir1(N, wc, 'low', boxcar(N+1));
w = -pi : 0.01 : pi;
H = freqz(h, 1, w);

%% Output 
figure;
subplot(2,1,1);
hold on
plot(w/pi, 20*log10(abs(H)));
xlabel('$Frequency, \pi rad/sample$', 'Interpreter','latex','FontSize', 16);
ylabel('$Magnitude (dB)$', 'Interpreter','latex','FontSize', 16);
title('Magnitude Response', 'Interpreter','latex','FontSize', 16);
grid on
ylim([-80 5])
subplot(2,1,2);
hold on
plot(w/pi, angle(H));
xlabel('$Frequency, \pi rad/sample$', 'Interpreter','latex','FontSize', 16);
ylabel('$Phase (radians)$', 'Interpreter','latex','FontSize', 16);
title('Phase Response', 'Interpreter','latex','FontSize', 16);
grid on

FileName = 'pic/Task_3.png';
print('-dpng', '-opengl', '-r300', FileName);