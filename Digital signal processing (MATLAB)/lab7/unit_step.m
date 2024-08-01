function [unit] = unit_step(n_0)
%unit_step -- is function to calculate the unit impuls
if (n_0 > 0)
    unit = 1;
else
    unit = 0 ;
end
