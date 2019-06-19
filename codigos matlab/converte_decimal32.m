%
% Função para converter número binário em decimal com sinal
% de no máximo 16 bits
%

function ndec = converte_decimal32(nbin)

if nbin(1) == '1'    
    if length(nbin)>32
        disp('Erro! Valor máximo de 32 bits excedido!');
        return
    end
    
    for i=1:length(nbin)
        if (nbin(i) == '0')
            nbin(i) = '1';
        else
            nbin(i) = '0';
        end
    end

    if(nbin(length(nbin)) == '1')
        nbin(length(nbin)) = '0';
        flag_soma = 1;
    else
        nbin(length(nbin)) = '1';
        flag_soma = 0;
    end
    
    for i=(length(nbin)-1):-1:1
        if(nbin(i) == '1' && flag_soma == 1)
            nbin(i) = '0';
            flag_soma = 1;
        elseif (nbin(i) == '0' && flag_soma == 1)
            nbin(i) = '1';
            flag_soma = 0;
        end
    end
    
    nbin = bin2dec(nbin)*(-1);
    
else
    nbin = bin2dec(nbin);
    if length(nbin)>32
        disp('Erro! Valor máximo de 32 bits excedido!');
        return
    end   
end

ndec = nbin;

end