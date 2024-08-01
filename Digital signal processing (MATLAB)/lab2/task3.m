clearvars
clc
addpath('lib')

%% This task results in the output of the frequency spectrum with 
% normalization of the frequency axis in such a way that the real 
% frequencies of the signal are displayed on the abscissa axis. Defines 
% the frequency components responsible for each DTMF symbol

%% create sequence (DTMF signals)
% parametrs
sequence = {'7','0', '1'};
% sequence = {'0', '6', '7', '8', '9', 'A', 'B', 'C', 'D', '*', '#', 'D', '*', '#', 'D', '*', '#'};
fs = 4000; 
duration = 0.5;

% creating
[row_freq, colomn_freq, time, signal, priority] = DTMF_sequence(sequence, duration, fs);

%% Standard MATLAB fft function
Matlab_fft = fft(signal);

%% Normalize frequency axis
N = length(signal);
f_real = (0:N-1);
f_real = f_real * fs / N;

%% output
figure;
subplot (211)
plot(f_real, abs(Matlab_fft));
xlabel('Frequency (Hz)', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$|X(k)|$', 'Interpreter', 'latex', 'FontSize', 16);
title('MATLAB FFT of DTMF Signal', 'Interpreter', 'latex', 'FontSize', 16);
grid on
subplot (212)
plot(f_real, angle(Matlab_fft));
xlabel('Frequency (Hz)', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\angle X(k)$', 'Interpreter', 'latex', 'FontSize', 16);
title('Phase of MATLAB FFT', 'Interpreter', 'latex', 'FontSize', 16);
grid on;

%% Find frequency components responsible for each DTMF symbol
% Frequencies for DTMF keypad (Hz)

freq = rebuild_freq_DTMF(Matlab_fft, N, fs, priority, sequence);

sequence_out = rebuild_symbols_DTMF(freq);

% Display DTMF symbols
disp('DTMF Symbols:');
disp(sequence_out);

FileName = 'pic/Task_3.png';
print('-dpng', '-opengl', '-r300', FileName);
