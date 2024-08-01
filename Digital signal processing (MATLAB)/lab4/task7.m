clearvars
clc
addpath('lib')

%% In this task, a digital high-pass filter is created with the following 
% parameters: cutoff frequency of 700 Hz, cutoff frequency of 500 Hz, 
% unevenness in the passband 0.55 dB, minimum attenuation in the cutoff 
% band 60 dB. Calculates the order of such a filter with Butterworth, 
% Chebyshev type 1, Chebyshev type 2, and elliptic approximations.

%% Parametrs
wp = 700;
ws = 500;  
Rp = 0.55;
Rs = 60;

% Calculating filter order
order_butterworth = buttord(wp, ws, Rp, Rs, 's');  
order_cheb1 = cheb1ord(wp, ws, Rp, Rs, 's');       
order_cheb2 = cheb2ord(wp, ws, Rp, Rs, 's');       
order_elliptic = ellipord(wp, ws, Rp, Rs, 's');  

% Filters creating
[b_butterworth, a_butterworth] = butter(order_butterworth, wp, 's');
[b_cheb1, a_cheb1] = cheby1(order_cheb1, Rp, wp, 's');
[b_cheb2, a_cheb2] = cheby2(order_cheb2, Rs, ws, 's');
[b_elliptic, a_elliptic] = ellip(order_elliptic, Rp, Rs, wp, 's');

% Frequency
w = linspace(0, 1000, 1000);

% Frequency response for all filters
H_butterworth = freqs(b_butterworth, a_butterworth, w * 2 * pi);
H_cheb1 = freqs(b_cheb1, a_cheb1, w * 2 * pi);
H_cheb2 = freqs(b_cheb2, a_cheb2, w * 2 * pi);
H_elliptic = freqs(b_elliptic, a_elliptic, w * 2 * pi);

%% Output
fprintf('Order Butterworth: %d\n', order_butterworth);
fprintf('Order Chebyshev type 1: %d\n', order_cheb1);
fprintf('Order Chebyshev type 2: %d\n', order_cheb2);
fprintf('Order elliptic: %d\n', order_elliptic);

% graphics
figure;
hold on;
semilogx(w, 20*log10(abs(H_butterworth)), 'b');
semilogx(w, 20*log10(abs(H_cheb1)), 'r');
semilogx(w, 20*log10(abs(H_cheb2)), 'g');
semilogx(w, 20*log10(abs(H_elliptic)), 'm');
xlabel('Frequency, Gz', 'Interpreter','latex','FontSize', 16);
ylabel('Magnitude, dB', 'Interpreter','latex','FontSize', 16);
title('Frequency response', 'Interpreter','latex','FontSize', 16);
legend('Butterworth', 'Chebyshev type 1', 'Chebyshev type 2', 'Elliptic');
grid on;

FileName = 'pic/Task_7.png';
print('-dpng', '-opengl', '-r300', FileName);