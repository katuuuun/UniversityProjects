clearvars
clc

N = 42;
n = 0:N-1;

x = cos(2 * pi * 0.1 * n);

x_ext = [x,x];     % periodic expansion 

        for i = 0:N-1
            R(i+1) = sum(x_ext(1:N) .* x_ext(i+1:N+i));
        end
        
        [PKS, loc] = findpeaks(R);
        [max_R, max_index] = max(PKS);
        
        T = loc(3) - loc(2) - 1;

        subplot(2, 1, 1);
        stem(n, x);
        title('Сигнал  x(n)');
        xlabel('n');
        ylabel('x(n)');

        subplot(2, 1, 2);
        stem(1:N-1, R(2:N));
        title('автокорреляционная функция');
        xlabel('Задержка');
        ylabel('R(i)');

        fprintf('Период: %d\n', T);

FileName = 'Task_2.png';
print('-dpng', '-opengl','-r300',FileName);        
        
        
        
        
        
        
