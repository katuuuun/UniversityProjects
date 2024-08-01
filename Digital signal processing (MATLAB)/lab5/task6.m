clearvars
clc

r = 0.9;
w = 2*pi\7;
n = 0:100;
z = r*exp(1i*w);
x = cplx_exp(z,n);
figure( 'Position',[100 100 500 500])
subplot(2,2,1);
plot(n, abs(x), 'r', 'LineWidth',2)
hold on
title('Комплексная экспонента')
ylabel('\(x(n)\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on

n = 0:100;
Im = r.^n.*sin(w*n);
Re = r.^n.*cos(w*n);
subplot(2,2,2);
plot(Im, 'r', 'LineWidth',2)
hold on
title('Мнимая часть')
ylabel('\(Im\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(2,2,3);
plot(Re, 'b', 'LineWidth',2)
hold on
title('Действительная часть')
ylabel('\(Re\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(2,2,4);
y = Re + i*Im;
plot(y, 'b', 'LineWidth',2)
hold on
title('Комплексная экспонента')
ylabel('\(Re\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(Im\)', 'Interpreter','latex','FontSize', 16)
grid on

%experement with Theta
figure( 'Position',[100 100 500 500])
subplot(2,2,1);
w = 2*pi/46;
z = r*exp(1i*w);
Im = r.^n.*sin(w*n);
Re = r.^n.*cos(w*n);
plot(Im, 'r', 'LineWidth',2)
hold on
title('Мнимая часть')
ylabel('\(Im\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(2,2,2);
plot(Re, 'b', 'LineWidth',2)
hold on
title('Действительная часть')
ylabel('\(Re\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(2,2,3)
w = 2*pi/20;
z = r*exp(1i*w);
Im = r.^n.*sin(w*n);
Re = r.^n.*cos(w*n);
plot(Im, 'r', 'LineWidth',2)
hold on
title('Мнимая часть')
ylabel('\(Im\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
subplot(2,2,4);
plot(Re, 'b', 'LineWidth',2)
hold on
title('Действительная часть')
ylabel('\(Re\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on

% plot3
figure( 'Position',[100 100 500 500])
w = 2*pi/7;
z = r*exp(1i*w);
x = cplx_exp(z,n);
Im = r.^n.*sin(w*n);
Re = r.^n.*cos(w*n);
plot3(Re,Im,n);
hold on
title('Комплексная экспонента 3D')
ylabel('\(Im\)', 'Interpreter','latex','FontSize', 16)
xlabel('\(Re\)', 'Interpreter','latex','FontSize', 16)
zlabel('\(n\)', 'Interpreter','latex','FontSize', 16)
grid on
