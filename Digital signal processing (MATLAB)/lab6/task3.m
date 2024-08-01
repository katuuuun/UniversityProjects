clearvars
clc

flag = 0;

[signal, fs] = audioread('02L3.wav');

% Signal options
segmentLength = 640; 
overlap = 160; 

numSegments = floor((length(signal) - overlap) / (segmentLength - overlap));

for i = 1:numSegments
        startIndex = (i - 1) * (segmentLength - overlap) + 1;
        endIndex = startIndex + segmentLength - 1;
        
        segment = signal(startIndex:endIndex);
        
        autocorr = AKF_function(segment, flag); % calculation AKF of function
        
        [PKS, loc] = findpeaks(autocorr);
        maxIndex = 0;
        max_R = max(PKS);
        for l = 1 : length(PKS)
            if PKS(l) == max_R
                maxIndex = loc(l);
            end
        end
        
        pitchPeriods(i) = maxIndex;
        
        flag = flag + 1;
        if i == numSegments-1
            flag = 0;
        end
end
    
    % graph output
    figure;
    plot(1:numSegments, pitchPeriods);
    xlabel('Номер сегмента');
    ylabel('Период основного тона');
    title('Период основного тона для каждого сегмента');
    
    % Output vean pitch period
    meanPitchPeriod = mean(pitchPeriods);
    fprintf('Средний период основного тона: %.2f отсчетов\n', meanPitchPeriod);
    
    FileName = 'Task_3.png';
    print('-dpng', '-opengl','-r300',FileName);
    
    
    
    
    