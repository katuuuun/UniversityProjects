function [Signal_power] = power_sig(x,N)
%power - is function for calculation power of signal
sum_signal = sum(abs(x) .^ 2);
Signal_power.value = (1 / N) .* sum_signal;
Signal_power.value_db = 10 * log10(Signal_power.value);
end

