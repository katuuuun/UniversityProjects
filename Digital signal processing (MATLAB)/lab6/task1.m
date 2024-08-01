clearvars
clc

N = 50;
n = 0:N-1;

x1 = 0.5 * sin(2 * pi * 2 / N * n);
x2 = cos(2 * pi * 0.1 * n);

Power_x1 = power_sig(x1, N);

Power_x2 = power_sig(x2, N);

ortogonal = sum(x1 .* x2) == 0;
mu_x1 = 1/N .* sum(x1);
mu_x2 = 1/N .* sum(x2);
corelation_coef = (sum((x1-mu_x1).*(x2-mu_x2)))/(sqrt((sum((x1-mu_x1).^2)) .* (sum((x2-mu_x2).^2))))