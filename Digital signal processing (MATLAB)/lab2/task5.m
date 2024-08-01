clearvars
clc
addpath('lib')

%% This task creates a spectrogram for the input signal with the 
% required Hann window parametrs. 

%% Load signal from file
% [x,fs] = audioread('audio/010.wav'); % read file
% [x,fs] = audioread('audio/2.wav'); % read file
% [x,fs] = audioread('audio/3.wav'); % read file
[x,fs] = audioread('audio/4.wav'); % read file
% [x,fs] = audioread('audio/5.wav'); % read file

Ln = length(x); % signal length

%% Analysis parameters
L = 32; % Overlap between frames
N = round(fs / 60); % size of frame for narrowband spectrogram
N_frames = floor((Ln - N) / L); % Number of frames
N_bins = round(N / 2) + 1; % numbers of effecrive frequency bins

%% Creates a spectrogram in 2 type of scale
[Spec_log, Spec_line] = spectrogram_log_linear(x, L, N);

time = (0 : N_frames - 1) * L / fs; % real time
freq = (0 : N_bins - 1) * fs / N; % real frequency

%% Output
figure('Position',[100 100 800 650]);
subplot(3,1,1);
plot(0 : Ln - 1, x); % signal
xlabel('Samples, (n)');
ylabel('Amplitude');
xlim([0 Ln-1]);

subplot(3,1,2);
pcolor(time, freq, Spec_line); % Linear spectrogram
shading flat;
colormap(jet);
ylabel('Frequency (Hz)');
xlabel('Time (t)');
colorbar;
title('Linear spectrogram');

subplot(3,1,3);
pcolor(time, freq, Spec_log); % Logorithmic spectrogram
shading flat;
colormap(jet);
set(gca,'CLim',[-75 -15]);
ylabel('Frequency (Hz)');
xlabel('Time (t)');
colorbar;
title('Logorithmic spectrogram');

FileName = 'pic/Task_5.png';
print('-dpng', '-opengl', '-r300', FileName);