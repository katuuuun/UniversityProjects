clearvars
clc
addpath('lib')

%% This task creates a polyharmonic signal at frequencies of 3, 7, 
% and 25 Hz, and then calculates an FIR filter that extracts the 25 Hz 
% component from the signal.

%% Parametrs
Fs = 128; 
T = 4; 
t = 0 : 1/Fs : T-1/Fs; 

%% Creating polisignal
frequencies = [3, 7, 25]; 
signal = zeros(size(t));
for i = 1:length(frequencies)
    signal = signal + sin(2*pi*frequencies(i)*t);
end

%% FIR filter 
N = 21;
wc = (frequencies(3) - 6 ) / (Fs/2); % Normolize
h = fir1(N, wc, 'high', 'noscale'); 

% use filter
filtered_signal = filter(h, 1, signal);

%% Output
figure;
subplot(211)
hold on
plot(t, signal);
xlabel('Time, s', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
title('Polyharmonic Signal', 'Interpreter','latex','FontSize', 16);
grid on

subplot(212)
hold on
plot(t, filtered_signal);
xlabel('Time, s', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
title('Filtered Signal (25 Hz Component)', 'Interpreter','latex','FontSize', 16);
grid on

FileName = 'pic/Task_4.png';
print('-dpng', '-opengl', '-r300', FileName);