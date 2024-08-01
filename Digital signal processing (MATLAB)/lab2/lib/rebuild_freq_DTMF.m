function [freq] = rebuild_freq_DTMF(Matlab_fft, N, fs, priority, sequence)
%% This function uses the DTMF signal to find the frequencies of 
% transmitted symbols

%% parametrs
frequencies_colomn = [1209, 1336, 1477, 1633];
frequencies_row = [697, 770, 852, 941];
freq_all = [frequencies_row, frequencies_colomn];
[a, locs] = findpeaks(abs(Matlab_fft), 'MinPeakHeight', 1000);
locs = locs * fs / N;
locs = floor(locs);
a = floor(a);
freq = zeros(1, 2*length(sequence));
j = 1;
check_values = [1000: 1100, 2000: 1000 : 15000];

%% check frequencies and collect frequencies of DTMF-signal
for i = 1 : length(a) 
    if ismember(abs(a(i)), check_values) 
        index_out = find(freq_all == locs(i)); % find locs(i) in freq_all
        if ismember(index_out, priority) % check locs(i) in priority
            freq(priority == index_out) = locs(i); % save locs(i) into freq
            j = j + 1;
        end
    end
end
end

