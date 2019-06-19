clear;
clc;
close all;

Ts = 1e-6;
Fs = 1/Ts;
L = 1500;             
t = (0:L-1)*Ts;
N = 80;

freq = 2500;
freq_alta = freq*10;

%Fc = (freq_alta+freq)/2;
Fc = 3000;

sinal = sin(2*pi*freq*t) + sin(2*pi*freq*10*t);

B = fir1(N, Fc/(Fs/2));
fvtool(B,1);

s_filt = conv(sinal,B);

figure();
subplot(211);
plot(sinal);
grid on;
subplot(212);
plot(s_filt);
grid on;
