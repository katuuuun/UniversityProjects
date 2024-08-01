clearvars
clc

%% This program finds the circular convolution of two sequences using the 
% convolution theorem, and also pads the sequences with zeros and finds 
% their linear convolution

%% parametrs
x_1 = [0 -1 1 -1 1 -1 0 0 0];
x_2 = [0 0.2 0.5 -1 0.5 0.2 0 0 0 ];

%% add 0 sequences 
max = (length(x_1) + length(x_2) - 1);

x_1_null = [x_1, zeros(1, max-length(x_1))];
x_2_null = [x_2, zeros(1, max-length(x_2))];


%% Circular_convolution
circular_convolution = ifft(fft(x_1) .* fft(x_2));
circular_length = 0: length(x_1)-1;

%% Linear convolution
linear_convolution = conv(x_1_null, x_2_null);
linear_length = 0: (2 * length(x_1_null)-2);

%% Output
figure('Position',[100 100 800 550]);
subplot(413)
hold on;
plot(circular_length, circular_convolution, 'r', 'LineWidth', 2);
stem(circular_length, circular_convolution, 'b', 'LineWidth', 2);
xlabel ('n', 'Interpreter', 'latex', 'FontSize', 16);
ylabel ('x(n)', 'Interpreter', 'latex', 'FontSize', 16);
title ('Circular convolution', 'Interpreter', 'latex', 'FontSize', 16);
ylim([-2, 2]);
grid on;

subplot(414)
hold on;
plot(linear_length, linear_convolution, 'r', 'LineWidth', 2);
stem(linear_length, linear_convolution, 'b', 'LineWidth', 2);
xlabel ('n', 'Interpreter', 'latex', 'FontSize', 16);
ylabel ('x(n)', 'Interpreter', 'latex', 'FontSize', 16);
title ('Linear convolution', 'Interpreter', 'latex', 'FontSize', 16);
ylim([-2, 2]);
xlim([0, 16]);
grid on;

subplot(411)
hold on;
plot(0:length(x_1)-1, x_1, 'r', 'LineWidth', 2);
stem(0:length(x_1)-1, x_1, 'b', 'LineWidth', 2);
xlabel ('n', 'Interpreter', 'latex', 'FontSize', 16);
ylabel ('$x_1(n)$', 'Interpreter', 'latex', 'FontSize', 16);
title ('First sequential', 'Interpreter', 'latex', 'FontSize', 16);
grid on;

subplot(412)
hold on;
plot(0:length(x_2)-1, x_2, 'r', 'LineWidth', 2);
stem(0:length(x_2)-1, x_2, 'b', 'LineWidth', 2);
xlabel ('n', 'Interpreter', 'latex', 'FontSize', 16);
ylabel ('$x_2(n)$', 'Interpreter', 'latex', 'FontSize', 16);
title ('Second sequential', 'Interpreter', 'latex', 'FontSize', 16);
grid on;

FileName = 'pic/Task_4.png';
print('-dpng', '-opengl', '-r300', FileName);

