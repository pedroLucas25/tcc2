clc;
clear all;% Limpa todas as variáveis
close all;% Fecha todas as janelas de imagens do matlab

Fs = 8000;            
Ts = 1/Fs;             
L = 1500;             
t = (0:L-1)*Ts; 

S = 2.5*sin(2*pi*200*t) + 0.8*sin(2*pi*800*t);

figure();
plot(t,S);
title('Sinal no tempo');
xlabel('Tempo(s)');
ylabel('Amplitude');
grid on;

Y1 = fft(S);

P2 = abs(Y1/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

figure();
stem(f,P1);
title('Espectro de amplitude de X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');
grid on;

% Projeto do filtro

M = 200;
fc_normalizada = (10*485*pi)/Fs;
wc = 2*pi*fc_normalizada;

n = 0:M-1;
w = (0.5*(1-cos((2*pi*n)/(M-1))))';

hd = ideal_lp(wc, M);

h = hd'.*w;

S_filtrado = conv(S, h);

Y2 = fft(S_filtrado);

P3 = abs(Y2/L);
P4 = P3(1:L/2+1);
P4(2:end-1) = 2*P4(2:end-1);
f = Fs*(0:(L/2))/L;

figure();
stem(f,P4);
title('Espectro de amplitude de X(t) filtrado');
xlabel('f (Hz)');
ylabel('|P4(f)|');
grid on;

figure();
plot(t,S_filtrado(1:length(t)));
title('Sinal filtrado no tempo');
xlabel('Tempo(s)');
ylabel('Amplitude');
grid on;