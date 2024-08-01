clearvars
clc
addpath('lib')

%% In this task, we search for a 4th order Chebyshev polynomial using the 
% formula T_n(x) = 2xT_{n-1}(x) - T_{n-2}(x). for x in range [-1.1 1.1].

%% Parametrs
x = -1.1 : 0.01 : 1.1;
T0 = ones(size(x));
T1 = x;
n = 4;
T = ones(n+1, length(x));
T(2, :) = x;

%% Chebyshev polynom
% auto n
for i = 3 : n+1
   T(i, :) = 2*x.*T(i-1, :) - T(i-2, :); 
end

% stupid use
T2 = 2*x.*T1 - T0;
T3 = 2*x.*T2 - T1;
T4 = 2*x.*T3 - T2;

%% Output
figure;
hold on;
plot(x, T);
legend('$T_0(x)$', '$T_1(x)$', '$T_2(x)$', '$T_3(x)$',...
    '$T_4(x)$', 'Interpreter','latex','FontSize', 16);
title('4th Order Chebyshev Polynomials', 'Interpreter',...
    'latex','FontSize', 16);
xlabel('$x$', 'Interpreter','latex','FontSize', 16);
ylabel('$T_n(x)$', 'Interpreter','latex','FontSize', 16);
grid on;

FileName = 'pic/Task_1.png';
print('-dpng', '-opengl', '-r300', FileName);