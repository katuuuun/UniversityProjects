clearvars
clc
addpath('lib')

%% This task select 0.25 s from signal and found his fft. Select base 
% frequencies and reconstructed this signal with selected frequencies.

%% Load signal from file
% [x,fs] = audioread('audio/010.wav'); % read file
[x,fs] = audioread('audio/4.wav'); % read file
% [x,fs] = audioread('audio/5.wav'); % read file

Ln = length(x); % signal length

%% Select 250 ms time period
duration = 0.25; 
N_samples = duration * fs; % Number of samples
x_segment = x(1 : N_samples); % Select segment

%% Determine the main frequency and Reconstruct a signal
threshold = 0.001; 
x_reconstructed = reconstructed_with_base_freq(x_segment, threshold);

%% Output
figure;
subplot(3, 1, 2);
plot((0:N_samples - 1) / fs, x_segment); % segment
xlabel('Time (t)');
ylabel('Amplitude');
title('Input segment');

subplot(3, 1, 3);
plot((0:N_samples - 1) / fs, x_reconstructed); % reconstructed segment
xlabel('Time (t)');
ylabel('Amplitude');
title('Reconstructed segment');

subplot(3,1,1);
plot(0 : Ln - 1, x); % signal
xlabel('Samples, (n)');
ylabel('Amplitude');
xlim([0 Ln-1]);

FileName = 'pic/Task_6.png';
print('-dpng', '-opengl', '-r300', FileName);