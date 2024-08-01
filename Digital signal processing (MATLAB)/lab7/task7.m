clearvars
clc

% string options
L = 70000;
fs = 44100; 
alpha = 0.995;
f_la1 = 440;
f_mi1 = 329.6;
f_si1 = 493.88;
f_la3 = 1720;
f_mi3 = 1318.5;
f_si3 = 1975.5;
M = round(fs/f_la1);
% M = round(fs/f_mi1);
% M = round(fs/f_si1);
% M = round(fs/f_la3);
% M = round(fs/f_mi3);
% M = round(fs/f_si3);

% generate signal x(n) with noise
x = zeros(1, L);
x(1:M) = (1 / 4) * (rand(1, M) - 0.5);

y = zeros(1, L);
y(1:M) = x(1:M);

% generate string sound
for n = M+1:L
    y(n) = x(n) + alpha * y(n - M);
end

sound(y, fs); % play sound

audiowrite('ks_out.wav', y, fs); % save sound