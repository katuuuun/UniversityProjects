clearvars
clc

% Calculate analog filter Butterworth
fcut = 4;
wc = 2*pi*fcut; % freq cut
n = 4; % filter order
[num, den] = butter(n, wc, 's');

% output
% f = linspace(1, 50);
w = logspace(-1, 2); % freq at log scale

H = freqs(num, den, w);
% semilogx(w, abs(H), 'k', 'LineWidth', 1.5);
% bode(tf(num, den));
plot(w/(2*pi), abs(H));
grid on;
ylabel('$|H(\omega)|$', 'Interpreter', 'latex');
xlabel('Frequency (Hz)', 'Interpreter', 'latex');
title('Frequency response Butterworth filter 4th order');

FileName = 'Task_4.png';
print('-dpng', '-opengl','-r300',FileName);