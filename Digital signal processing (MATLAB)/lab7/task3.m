clearvars
clc

mu = 255;
x_n = -1:0.1:1;
for i = 1:length(x_n)
    sign_resl(i) = sign_function(x_n(i));
end 

y_n = sign_resl.*(log10(1 + mu*abs(x_n))/log10(1+mu));

% check additivity
x = x_n(5) + x_n(12);
sign_resl = sign_function(x);
y = sign_resl.*(log10(1 + mu*abs(x))/log10(1+mu));
y5 = y_n(5);
y12 = y_n(12);
y_final = y5 + y12;
if y_final == y
    fprintf('функция аддитивна\n');
else
    fprintf('функция не аддитивна\n');
end

% check uniformity
x = x_n(3) * 5;
sign_resl = sign_function(x);
y = sign_resl.*(log10(1 + mu*abs(x))/log10(1+mu));
y3 = 5 * y_n(3);
if y3 == y
    fprintf('функция однородна\n');
else
    fprintf('функция не однородна\n');
end

% linearity check
x = 2 * x_n(4) + 3 * x_n(7);
sign_resl = sign_function(x);
y = sign_resl.*(log10(1 + mu*abs(x))/log10(1+mu));
sign_resl = sign_function(x_n(4));
y4 =  sign_resl.*(log10(1 + mu*abs(x_n(4)))/log10(1+mu));
sign_resl = sign_function(x_n(7));
y7 = sign_resl.*(log10(1 + mu*abs(x_n(7)))/log10(1+mu));
y_final = 2* y4 + 3*y7;
if y_final == y
    fprintf('функция линейная\n');
else
    fprintf('функция не линейная\n');
end

% stationarity check
x = x_n(4-2);
sign_resl = sign_function(x);
y = sign_resl.*(log10(1 + mu*abs(x))/log10(1+mu));
y_final = y_n(4-2);
if y_final == y
    fprintf('функция стационарна\n');
else
    fprintf('функция не стационарна\n');
end
