function saida = plot_arquivo32(nome_arquivo)

fid = fopen(nome_arquivo, 'r');

sinais = fscanf(fid,'%s', [32 Inf]);
sinais = sinais';

for i=1:length(sinais)
    aux(i) = string(sinais(i,1:32)); %#ok<AGROW>
end

aux = aux';

for i=1:length(aux)
    aux_saida(i) = converte_decimal32(char(aux(i))); %#ok<AGROW>
end

saida = aux_saida;

end