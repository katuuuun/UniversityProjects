function [ConSin, t] = continuous_sin(A, f_0, f_s, t_0, t_1, phi_0)
%continuous_sin -- is function to calculate the continuous sinus function
%s(t) = Asin(2\pi f_0 t+ \varphiup_0)
t = t_0:1/f_s:t_1;
ConSin = A*sin(2*pi*f_0*t+phi_0);
end

