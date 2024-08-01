clearvars
clc

% AR(1) process options
rho = 0.5;    
sigma_sq = 10;
C = 0;

T = 100; % Number of point
X = zeros(T, 1); %generation temp X 

delay = 10; % Delay by 10 time units
weakening_factor = 0.5; % Weakening by 2 times

dispersion = [1, 2, 5]; % dispersion
Y = zeros(T, 3);

    % Generation
    for t = 2:T
        epsilon = sqrt(sigma_sq) * randn(); 
        X(t) = C + rho * X(t-1) + epsilon;      
    end
    
% generate signal with delay
delayed_X = [zeros(delay, 1); X(1:T-delay)]; % Delay
X_delay = weakening_factor * delayed_X; % Weakening

    % dispersion 1, 2, 5
    for i = 1:3
        noise = sqrt(dispersion(i)) * randn(T, 1);
        Y(:, i) =  X_delay + noise;
    end

% Correlation between x(n) and y(n)
corr_x_y1 = xcorr(X, Y(:, 1));
corr_x_y2 = xcorr(X, Y(:, 2));
[corr_x_y3, lag] = xcorr(X, Y(:, 3));

% graph output
subplot(4, 2, 1);
plot(X);
title('AR(1) процесс с \rho = 0.5 и \sigma^2 = 10');
xlabel('Время');
ylabel('Значение');

% Delay graph output
subplot(4, 2, 2);
plot(X_delay);
title('Задержанный и ослабленный AR(1) процесс');
xlabel('Время');
ylabel('Значение');

% dispersion 1, 2, 5
subplot(4, 2, 3);
plot(Y(:, 1));
title('Сигнал с добавленным шумом (дисперсия 1)');

subplot(4, 2, 4);
plot(Y(:, 2));
title('Сигнал с добавленным шумом (дисперсия 2)');

subplot(4, 2, 5);
plot(Y(:, 3));
title('Сигнал с добавленным шумом (дисперсия 5)');

% correlation function
subplot(4, 2, 6);
plot(lag, corr_x_y1);
title('Корреляция между x(n) и y1(n)');

subplot(4, 2, 7);
plot(lag, corr_x_y2);
title('Корреляция между x(n) и y2(n)');

subplot(4, 2, 8);
plot(lag, corr_x_y3);
title('Корреляция между x(n) и y3(n)');

FileName = 'Task_5.png';
print('-dpng', '-opengl','-r300',FileName);
