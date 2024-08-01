function [row_freq, colomn_freq, time, signal, priority] = DTMF_sequence(sequence, duration, fs)
% This function creates the required sequence of DTMF 
% signals with the required duration and sampling rate 

%% parametrs
frequencies_colomn = [1209, 1336, 1477, 1633];
frequencies_row = [697, 770, 852, 941];
seq_priority = 1:8;
priority_row = zeros(1, length(sequence));
priorit_colomn = zeros(1, length(sequence));
% ready_freq = 350;

t = 0:1/fs:duration-1/fs; 
time = [];
f = 0;

signal = [];
symbols = {'1', '2', '3', 'A';
           '4', '5', '6', 'B';
           '7', '8', '9', 'C';
           '*', '0', '#', 'D'};

%% check sequence and generate DTMF-signal
[row, colomn] = size(symbols);
row_freq = zeros(1, length(sequence));
colomn_freq = zeros(1, length(sequence));
found_flag = false;
for i = 1:length(sequence)
    for j = 1 : row     % check input sequence
        for k = 1 : colomn
            if strcmp(sequence{i}, symbols{j, k})  
                priority_row(i) = seq_priority(j);
                priorit_colomn(i) = seq_priority(4 + k);
                row_freq(i) = frequencies_row(j);       % row frequencies for this symbols of sequence
                colomn_freq(i) = frequencies_colomn(k); % colomn frequencies for this symbols of sequence
                found_flag = 'true';                    % this symbol in base symbols
            end
        end
    end
    if ~found_flag  % Changed to logical value ?
            error('Symbol not in the row!'); % exit the program if symbol is not found
    end
    found_flag = false; 
end

priority = [priority_row, priorit_colomn];

for i = 1:length(sequence)
    sin_in_row = sin(2*pi*row_freq(i)*t);
    sin_in_colomn = sin(2*pi*colomn_freq(i)*t);
    result_sin_symbol = sin_in_row + sin_in_colomn;
    signal = [signal, result_sin_symbol];
    time = [time, f + t]; % adding time for the signal
    f = f + duration;     % increasing time by signal duration
    
    pause_signal = zeros(1, fs*duration); % pause 0.5 s
    signal = [signal, pause_signal];
    time = [time, f + t]; % adding time for the pause
    f = f + duration;     % increasing time by pause duration
end

%% if you need a signal readiness block we use this part
% sin_ready = sin(2*pi*ready_freq*t);   % signal ready
% signal = [signal, sin_ready];     

end

