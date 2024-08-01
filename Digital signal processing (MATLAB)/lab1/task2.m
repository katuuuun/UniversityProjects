clearvars
clc

% signal parametrs
fc = 0.5;
fm = 20;

syms t w f;   % symbolic variables 
x_t = sin(2*pi*fc.*t).*sin(2*pi*fm.*t)*(heaviside(t - 0) - heaviside(t-10));
X_F = fourier(x_t, w);  % fourier analyse
disp(X_F);
X_F = subs(X_F, w, 2*pi*f);
disp(X_F);  % disp X(f)

figure('Position',[100 100 600 600])

subplot(2,1,1)
fplot(abs(X_F), [-25, 25], 'LineWidth', 2);
ylim([0, 3]);
title('Amplitude');
xlabel('$f$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$|X(f)|$', 'Interpreter', 'latex', 'FontSize', 16);
grid on

subplot(2,1,2)
fplot(angle(X_F), [-25, 25], 'LineWidth', 2);
title('Phase');
xlabel('$f$', 'Interpreter', 'latex', 'FontSize', 16);
ylabel('$\angle X(f)$', 'Interpreter', 'latex', 'FontSize', 16);
grid on

FileName = 'Task_2.png';
print('-dpng', '-opengl', '-r300', FileName);
