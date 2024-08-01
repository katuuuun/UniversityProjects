clearvars
clc
addpath('lib')

%% In this task, using the invariant impulse response method, the transfer 
% function of a digital IIR filter obtained from an analog filter with a 
% transfer function H(s) = 1/(s+1) is found. The frequency response, phase
% response and impulse response of the resulting filter are plotted





% У нас нет нулей поэтому num = 1 и один полюс поэтому den = [1,1]. 
% тип фильтра ('whole' указывает, что мы хотим оценить АЧХ на всем диапазоне частот)
% МБ глянуть бы как формируется den и num 




%% Parametrs
% Analog transfer function H(s) = 1/(s+1) 
num = 1; % = 1, because absence of zeros in the transfer function.
den = [1, 1]; % one pole at s=−1.

Fs = 500;  

% Conversion to digital transfer function using invariant impulse response method
[num_digital, den_digital] = impinvar(num, den, Fs);

% Frequency response and phase response of a digital filter
[H_digital, w] = freqz(num_digital, den_digital, 'whole', Fs); 
phase_digital = angle(H_digital);

% Constructing the impulse response of a digital filter
impulse_response = impz(num_digital, den_digital);

%% Output
figure;
hold on;
subplot(3,1,1);
plot(w, abs(H_digital));
title('Frequency response', 'Interpreter','latex','FontSize', 16);
xlabel('Frequency, Gz', 'Interpreter','latex','FontSize', 16);
ylabel('Magnitude, dB', 'Interpreter','latex','FontSize', 16);
grid on;

hold on;
subplot(3,1,2);
plot(w, phase_digital);
title('Phase response', 'Interpreter','latex','FontSize', 16);
xlabel('Frequency', 'Interpreter','latex','FontSize', 16);
ylabel('Phase', 'Interpreter','latex','FontSize', 16);
grid on;

hold on;
subplot(3,1,3);
stem(0:numel(impulse_response)-1, impulse_response);
title('Impulse response of a digital IIR filter',...
    'Interpreter','latex','FontSize', 16);
xlabel('N', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
grid on;

FileName = 'pic/Task_4.png';
print('-dpng', '-opengl', '-r300', FileName);