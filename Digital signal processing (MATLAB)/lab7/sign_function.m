function [sign_res] = sign_function(x_n)
%sign is function that equal 1 if x > 0, 0 if x = 0, -1 if x < 0
if(x_n > 0)
    sign_res = 1;
elseif(x_n == 0) 
    sign_res = 0;
elseif(x_n < 0)
    sign_res = -1;
end

