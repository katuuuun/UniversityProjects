clearvars
clc

syms t w;
fc = 0.5;
fm = 20;
x = (cos(2*pi*1*t) + sin(2*pi*fc.*t).*sin(2*pi*fm.*t)).*(heaviside(t - 0) - heaviside(t-10));
X = fourier(x); 

fcut = 4;
wc = 2*pi*fcut; % f cut
n=4; % filter order

[zb,pb,kb] = butter(n, wc, "s");

syms s Hs f
s = 1j*w;

Hs = kb/((s-pb(1))*(s-pb(2))*(s-pb(3))*(s-pb(4)));
Hs = poly2sym(Hs); 
X_f_out = Hs*X;
X = subs(X, w, 2*pi*f);
X_f_out = subs(X_f_out, w, 2*pi*f);
%%
figure(1);
 
subplot(1,2,1)
fplot(abs(X), [-25, 25], 'b');
title('Input signal', 'Interpreter','latex','FontSize', 16);
xlabel('time (s)', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
ylim([0, 3.5])
subplot(1,2,2)
fplot(abs(X_f_out), [-25, 25], 'b')
title('Output signal', 'Interpreter','latex','FontSize', 16);
xlabel('time (s)', 'Interpreter','latex','FontSize', 16);
ylabel('Amplitude', 'Interpreter','latex','FontSize', 16);
ylim([0, 3.5])

FileName = 'Task_6.png';
print('-dpng', '-opengl','-r300',FileName);

