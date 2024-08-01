clearvars
clc
addpath('lib')

%% In this task, a low-pass filter with Butterworth approximation is 
% calculated using a filter order of 5, a cutoff frequency of 60 Hz, and a 
% sampling frequency of 200 Hz. Builds the frequency response, phase 
% response, diagram of the location of zeros and poles of the transfer 
% function. Plots a three-dimensional plot of the magnitude of the 
% filter's transfer function.

%% Parametrs
n_butterworth = 5;
fcut = 60;
fs = 200;
omega = 0: 1/fs :pi;

%% Butterworth filter 
% Butterworth filter coefficients
[b, a] = butter(n_butterworth, fcut/(fs/2), 'low');

% Frequency and phase characteristics of the filter
[H, w] = freqz(b, a, 1024, fs);
magnitude = abs(H);
phase = angle(H);

%% Output 
% Diagram of the location of zeros and poles 
figure;
zplane(b, a);
title('Diagram of the location of zeros and poles', 'Interpreter','latex','FontSize', 16);
xlabel('Real Part', 'Interpreter','latex','FontSize', 16);
ylabel('Imaginary Part', 'Interpreter','latex','FontSize', 16);

FileName = 'pic/Task_5_1.png';
print('-dpng', '-opengl', '-r300', FileName);

% Frequency response and phase response
figure;
subplot(2, 1, 1);
plot(w, 20*log10(magnitude));
title('Frequency response', 'Interpreter','latex','FontSize', 16);
xlabel('Frequency, Gz', 'Interpreter','latex','FontSize', 16);
ylabel('Magnitude, dB', 'Interpreter','latex','FontSize', 16);
grid on;

subplot(2, 1, 2);
plot(w, phase);
title('Phase response', 'Interpreter','latex','FontSize', 16);
xlabel('Frequency', 'Interpreter','latex','FontSize', 16);
ylabel('Phase', 'Interpreter','latex','FontSize', 16);
grid on;

FileName = 'pic/Task_5_2.png';
print('-dpng', '-opengl', '-r300', FileName);

% 3D graph of transfer function modulus
figure;
zplane(b,a)
[hw,fw] = freqz(b,a,1024,"whole");

z = roots(b);
p = roots(a);

plot3(cos(fw),sin(fw), abs(hw))
hold on
plot3(cos(fw),sin(fw),zeros(size(fw)),'--')
plot3(real(z),imag(z),zeros(size(z)),'o')
plot3(real(p),imag(p),zeros(size(p)),'x')
hold off
xlabel("Real", 'Interpreter','latex','FontSize', 16)
ylabel("Imaginary", 'Interpreter','latex','FontSize', 16)
view(35,40)
grid

FileName = 'pic/Task_5_3.png';
print('-dpng', '-opengl', '-r300', FileName);

%% % % % % % % % % % % % % % % % % % % % % % % % % % % 


% % Convert to Cartesian coordinates
% x = cos(fw);
% y = sin(fw);
% z = abs(hw);
% 
% % Create a grid
% Nx = 100;
% Ny = 100;
% [X, Y] = meshgrid(linspace(min(x), max(x), Nx), linspace(min(y), max(y), Ny));
% 
% % Interpolate the data onto the grid
% Z = griddata(x, y, z, X, Y);
% 
% % Plot the surface
% figure;
% surf(X, Y, Z);
% xlabel("Real", 'Interpreter','latex','FontSize', 16);
% ylabel("Imaginary", 'Interpreter','latex','FontSize', 16);
% zlabel("Magnitude", 'Interpreter','latex','FontSize', 16);
% 
% FileName = 'pic/Task_5_4.png';
% print('-dpng', '-opengl', '-r300', FileName);


%% % % % % % % % 


% % Create grid for real and imaginary parts of z
% Nx = 40; % Number of points in the x-direction
% Ny = 40; % Number of points in the y-direction
% x = linspace(-2, 2, Nx); % Range for real part of z
% y = linspace(-2, 2, Ny); % Range for imaginary part of z
% [X, Y] = meshgrid(x, y); % Create grid
% 
% % Convert grid to complex numbers
% Z = X + 1i * Y;
% 
% % Evaluate frequency response at each point in the grid
% mag_H = zeros(size(Z));
% for i = 1:size(Z, 1)
%     for j = 1:size(Z, 2)
%         % Calculate the frequency response at the current point using the transfer function formula
%         H_point = abs(polyval(b, Z(i, j)) / polyval(a, Z(i, j)));
%         mag_H(i, j) = H_point;
%     end
% end
% 
% % Plot surface
% figure;
% surf(X, Y, mag_H);
% title('Magnitude Response Surface', 'Interpreter','latex','FontSize', 16);
% xlabel('Real(z)', 'Interpreter','latex','FontSize', 16);
% ylabel('Imaginary(z)', 'Interpreter','latex','FontSize', 16);
% zlabel('|H(z)|', 'Interpreter','latex','FontSize', 16);

%% % % % 


% figure;
% [W, W_norm] = meshgrid(w, fs/2*w/pi);
% magnitude_matrix = repmat(abs(H), 1, size(W, 2)); 
% surf(W, W_norm, magnitude_matrix);  
% title('3D graph of transfer function modulus', 'Interpreter','latex','FontSize', 16);
% xlabel('Frequency', 'Interpreter','latex','FontSize', 16);
% ylabel('Normalized frequency', 'Interpreter','latex','FontSize', 16);
% zlabel('Transfer function module', 'Interpreter','latex','FontSize', 16);




