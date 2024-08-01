clearvars
clc
addpath('lib')

%% This task creates the required sequence of DTMF signals 
% with the required duration and sampling rate

%% create sequence (DTMF signals)
% parametrs
sequence = {'7', '0', '1'};
%    sequence = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', '*', '#'};
fs = 4000; 
duration = 0.05;

% creating
[~, ~, time, signal, ~] = DTMF_sequence(sequence, duration, fs);

%% output
figure;
plot(time, signal);
hold on
xlabel('Time (s)', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
title('DTMF Signal', 'Interpreter','latex','FontSize', 16);
grid on;

sound(signal, fs);  % sound signal

FileName = 'pic/Task_1.png';
print('-dpng', '-opengl', '-r300', FileName);
