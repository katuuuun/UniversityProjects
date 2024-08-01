clearvars
clc
addpath('lib')

%% This task implements the DFT function using only the sine and cosine 
% functions, and also tests the operation of this function in comparison 
% with the standard MATLAB fft function using the example of a DTMF signal 
% with a certain sequence

%% create sequence (DTMF signals)
% parametrs
sequence = {'7', '0', '1'};
fs = 4000; 
duration = 0.5;

% creating
[row_freq, colomn_freq, time, signal, priority] = DTMF_sequence(sequence, duration, fs);

f = 20*log10(linspace(1, 2000, 12000));

%% Standard MATLAB fft function
disp('Time of Matlab FFT:')
tic
Matlab_fft = fft(signal);
toc

%% My dft function
disp('Time of My DFT:')
tic
My_DFT = my_DFT(signal);
toc

%% output
figure('Position',[300 200 800 600]);
subplot (411)
% semilogx(f, abs(Matlab_fft), 'k', 'LineWidth', 1.5);
plot(f, 20*log10(abs(Matlab_fft)));
xlabel('Frequency (Hz)', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$|X(k)|$', 'Interpreter', 'latex', 'FontSize', 16);
title('MATLAB FFT of DTMF Signal', 'Interpreter', 'latex', 'FontSize', 16);
grid on
subplot (412)
plot(f, angle(Matlab_fft));
xlabel('Frequency (Hz)', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\angle X(k)$', 'Interpreter', 'latex', 'FontSize', 16);
title('Phase of MATLAB FFT', 'Interpreter', 'latex', 'FontSize', 16);
grid on;

subplot (413)
plot(f, abs(My_DFT));
xlabel('Frequency (Hz)', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$|X(k)|$', 'Interpreter', 'latex', 'FontSize', 16);
title('My DFT of DTMF Signal', 'Interpreter', 'latex', 'FontSize', 16);
grid on
subplot (414)
plot(f, angle(My_DFT));
xlabel('Frequency (Hz)', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\angle X(k)$', 'Interpreter', 'latex', 'FontSize', 16);
title('Phase of My FFT', 'Interpreter', 'latex', 'FontSize', 16);
grid on

FileName = 'pic/Task_2.png';
print('-dpng', '-opengl', '-r300', FileName);
