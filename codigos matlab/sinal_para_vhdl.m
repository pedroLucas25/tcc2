% Lembrar q os sinais na saída foram muitliplicados por um valor de 10.000
% para que não precisassem de um tratamento de número fixo.
% Após a realização do processo pelo código vhdl, deve-se dividir os
% valores obtidos pela mesma constante de 10.000

clc;
clear;
close all;

%%%%% Variáveis utilizadas para o cálculo das senóides ecoadas %%%%%%%%%%%%

Ts = 1e-6; % Período de amostragem
Fs = 1/Ts; % Frequênica de amostragem
L = 1500;  % Número de amostras           
t = (0:L-1)*Ts; % Tempo entre as amostras

dt = Ts;
frequencia = 1e4; %Frequênica do sinal 
c = 3e8;
lambda = c/frequencia;

num_mp = 3;
amp_mp = [1 0.7 0.5];
tau_mp = [0 1e-4 1.5e-4];

num_ant = 4;
d = lambda/4;

theta_inc = [pi/20 pi/4 11*pi/6];

%%%% Cálculo das senóides que passaram pelo efeito de multi percurso %%%%%%

antena1 = amp_mp(1)*sin(2*pi*frequencia*t) + amp_mp(2)*sin(2*pi*frequencia*(t - tau_mp(2))) + amp_mp(3)*sin(2*pi*frequencia*(t - tau_mp(3)));

antena2 = amp_mp(1)*sin(2*pi*frequencia*(t - (d/c)*sin(theta_inc(1)))) + ...
    amp_mp(2)*sin(2*pi*frequencia*(t - tau_mp(2) - (d/c)*sin(theta_inc(2)))) + ...
    amp_mp(3)*sin(2*pi*frequencia*(t - tau_mp(3) - (1/frequencia)+(d/c)*sin(theta_inc(3))));

antena3 = amp_mp(1)*sin(2*pi*frequencia*(t - 2*(d/c)*sin(theta_inc(1)))) + ...
    amp_mp(2)*sin(2*pi*frequencia*(t - tau_mp(2) - 2*(d/c)*sin(theta_inc(2)))) + ...
    amp_mp(3)*sin(2*pi*frequencia*(t - tau_mp(3) - (1/frequencia)+(d/c)*sin(theta_inc(3))));

antena4 = amp_mp(1)*sin(2*pi*frequencia*t + 3*(d/c)*sin(theta_inc(1))) + ...
    amp_mp(2)*sin(2*pi*frequencia*t + tau_mp(2) + 3*(d/c)*sin(theta_inc(2))) + ...
    amp_mp(3)*sin(2*pi*frequencia*t + tau_mp(3) + (1/frequencia)+3*(d/c)*sin(theta_inc(3)));

abs_antena1 = abs(antena1);
abs_antena2 = abs(antena2);
abs_antena3 = abs(antena3);
abs_antena4 = abs(antena4);

%%%%%%%%%%%%%%%%%%%%%%% Filtro %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

B = fir1(100, 1e2/(Fs/2));

s1 = conv(abs_antena1, B);
s2 = conv(abs_antena2, B);
s3 = conv(abs_antena3, B);
s4 = conv(abs_antena4, B);

% figure();
% plot(t, s1(1:length(t)), t, s2(1:length(t)), t, s3(1:length(t)), t, s4(1:length(t)));
% % plot(t, s1, t, s2, t, s3, t, s4);
% grid on;
% title('Potência média dos sinais recebidos');
% xlabel('Amostras');
% ylabel('Amplitude');

%%%%%%%%% Realizar a operação que escolhe o sinal com maior potência %%%%%%

y = zeros(1,length(s1));

for i = 1:L
    if((s1(i)>s2(i)) && (s1(i)>s3(i)) && (s1(i)>s4(i)))
        y(i) = antena1(i);
    elseif(s2(i)>s1(i) && s2(i)>s3(i) && s2(i)>s4(i))
        y(i) = antena2(i);
    elseif(s3(i)>s1(i) && s3(i)>s2(i) && s3(i)>s4(i))
        y(i) = antena3(i);
    elseif(s4(i)>s1(i) && s4(i)>s2(i) && s4(i)>s3(i))
        y(i) = antena4(i);
    else 
        y(i) = antena1(i);
    end
end

% figure();
% plot(y);
% grid on;
% title('Sinal de saida');
% xlabel('Amostras');
% ylabel('Amplitude');

%%%%%%%%%%%%% Converter para binário %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

antena1e4 = int16(antena1*1e4);
antena2e4 = int16(antena2*1e4);
antena3e4 = int16(antena3*1e4);
antena4e4 = int16(antena4*1e4);
filtroE4 = int16(B*1e4);


for i=1:length(antena1e4)
    antena1_bin(i,1) = string(converte_binario(antena1e4(i)));%#ok<SAGROW>
    antena2_bin(i,1) = string(converte_binario(antena2e4(i)));%#ok<SAGROW>
    antena3_bin(i,1) = string(converte_binario(antena3e4(i)));%#ok<SAGROW>
    antena4_bin(i,1) = string(converte_binario(antena4e4(i)));%#ok<SAGROW>
end

for i=1:length(filtroE4)
    filtro_bin(i,1) = string(converte_binario(filtroE4(i))); %#ok<SAGROW>
end

%%%%%%% Salvar os arquivos em .txt para leitura do VHDL %%%%%%%%%%%%%%%%%%%

fid_filtro = fopen('coef_filtro.txt','wt');

for i=1:length(filtro_bin)
    fprintf(fid_filtro, '"%s", ', filtro_bin(i));
end

fclose(fid_filtro);

fid_sinal1 = fopen('sinal1.txt', 'wt');
fid_sinal2 = fopen('sinal2.txt', 'wt');
fid_sinal3 = fopen('sinal3.txt', 'wt');
fid_sinal4 = fopen('sinal4.txt', 'wt');

for i=1:length(antena1_bin)
    fprintf(fid_sinal1, '%s\n', antena1_bin(i));
    fprintf(fid_sinal2, '%s\n', antena2_bin(i));
    fprintf(fid_sinal3, '%s\n', antena3_bin(i));
    fprintf(fid_sinal4, '%s\n', antena4_bin(i));
end

fclose(fid_sinal1);
fclose(fid_sinal2);
fclose(fid_sinal3);
fclose(fid_sinal4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

