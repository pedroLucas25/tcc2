%
% Função para converter número decimal em binário com sinal
% de no máximo 16 bits
%
% Entrada máxima de -32768 até 32767
%

function nbin = converte_binario(ndec)

if ndec<0    
    aux_ent = abs(ndec);    
    aux_saida = dec2bin(aux_ent);
    if length(aux_saida)>=16
        disp('Erro! Valor máximo de 16 bits excedido!');
        return
    end
    
    while(length(aux_saida)<16)
        aux_saida = strcat('0',aux_saida);
    end
    
    for i=1:length(aux_saida)
        if (aux_saida(i) == '0')
            aux_saida(i) = '1';
        else
            aux_saida(i) = '0';
        end
    end

    if(aux_saida(length(aux_saida)) == '1')
        aux_saida(length(aux_saida)) = '0';
        flag_soma = 1;
    else
        aux_saida(length(aux_saida)) = '1';
        flag_soma = 0;
    end
    
    for i=(length(aux_saida)-1):-1:1
        if(aux_saida(i) == '1' && flag_soma == 1)
            aux_saida(i) = '0';
            flag_soma = 1;
        elseif (aux_saida(i) == '0' && flag_soma == 1)
            aux_saida(i) = '1';
            flag_soma = 0;
        end
    end
    
else
    aux_saida = dec2bin(ndec);
    if length(aux_saida)>=16
        disp('Erro! Valor máximo de 16 bits excedido!');
        return
    end  
    
    while(length(aux_saida)<16)
        aux_saida = strcat('0',aux_saida);
    end  
end

nbin = aux_saida;

end