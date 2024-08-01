function [delta] = delta_fun(n)
%delta -- is function to calculate the unit jump
% len_N = length(n);
% delta = zeros(1, len_N);
% if (n_0 == 0)
%     delta = 1;
% else
%     delta = 0 ;
% end

delta = n == 0;
end

