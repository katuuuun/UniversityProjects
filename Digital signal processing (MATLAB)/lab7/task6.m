clearvars
clc

% sistem operation
M = 100; 
w = linspace(0, 2 * pi, 1000);

% sistem coeff
b = [0, 1];
a = [1, 0, 0.1, -0.1];

% impulse response h(m)
x = zeros(1, M+1);
x(1) = 1;
h = filter(b, a, x);

% calculation frequency response H(exp(jw))
H = zeros(size(w));
for i = 1:length(w)
    H(i) = sum(h .* exp(-1i * w(i) * (0:M)));
end

% calculation frequency response and phase response
frequency_response_H = abs(H);
phase_response_H = angle(H);

% graph frequency response and phase response output 
subplot(2, 1, 1);
plot(w, frequency_response_H, 'b', 'LineWidth', 1.5);
title('Амплитудная частотная характеристика (АЧХ)', 'FontSize', 14);
xlabel('Частота', 'FontSize', 14);
ylabel('\(|H(e^{j\omega})|\))', 'Interpreter','latex','FontSize', 14);
grid on;

subplot(2, 1, 2);
plot(w, phase_response_H, 'r', 'LineWidth', 1.5);
title('Фазовая частотная характеристика (ФЧХ)','FontSize', 14);
xlabel('Частота','FontSize', 14);
ylabel('Фаза','FontSize', 14);
grid on;

FileName = 'Task_6.png';
print('-dpng', '-opengl','-r300',FileName);
