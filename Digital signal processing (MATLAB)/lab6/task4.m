clearvars
clc

[signal, fs] = audioread('02L4.wav');

% options
threshold = -20;
N = 100;


    [x_v, x_u] = vu_separate(signal, N, threshold); % call function

    audiowrite('вокализованный.wav', x_v, fs); % save vocal signal
    audiowrite('невокализованный.wav', x_u, fs); % save unvocal signal
     
% graph output
figure(1);
subplot(3, 1, 1);
plot(x_v);
title('Вокализированный');
    
subplot(3, 1, 2);
plot(x_u);
title('Не вокализированный');
    
subplot(3, 1, 3);
plot(signal);
title('Сигнал');

FileName = 'Task_4.png';
print('-dpng', '-opengl','-r300',FileName);