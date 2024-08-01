function [sequence_out] = rebuild_symbols_DTMF(freq)
%% This function receives the required characters in the correct sequence 
% based on the frequencies of the DTMF signal

%% parametrs
frequencies_colomn = [1209, 1336, 1477, 1633];
frequencies_row = [697, 770, 852, 941];
sequence_out = cell(1, length(freq)/2);
row = zeros(1,length(freq)/2);
colomn = zeros(1, length(freq)/2);
index_row = zeros(1,length(freq)/2);
index_colomn = zeros(1, length(freq)/2);
symbols = {'1', '2', '3', 'A';
           '4', '5', '6', 'B';
           '7', '8', '9', 'C';
           '*', '0', '#', 'D'};
       
%% check frequencies of DTMF-signal and save symbols 
for i = 1 : length(freq)/2
    row(i) = freq(i);
    colomn(i) = freq(length(freq)/2 + i);
    for j = 1 : length(frequencies_row)
        for k = 1 : length(frequencies_colomn)
            if (colomn(i) == frequencies_colomn(k) || colomn(i) == frequencies_colomn(k) + 1 || colomn(i) == frequencies_colomn(k) - 1)
                index_colomn(i) = k;
            end
        end
        if (row(i) == frequencies_row(j) || row(i) == frequencies_row(j) + 1 || row(i) == frequencies_row(j) - 1)
           index_row(i) = j;
        end
    end
    sequence_out(i) = symbols(index_row(i), index_colomn(i));
 end
end

