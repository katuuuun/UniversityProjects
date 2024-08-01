function [unit] = unit_step(n)
%unit_step -- is function to calculate the unit impuls
% len_N = length(n);
%unit = zeros(1, len_N);
unit = n > 0;
end
