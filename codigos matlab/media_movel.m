%noise = randn(1,length(t));
%singal = waverecord(11025*10,11025);
%waveplay(signal, 11025);

function filter = media_movel(signal)

for i = 2:length(signal)
    
    filter(i) = (signal(i) + signal(i-1))/(2);
    
end

figure();

plot(filter);

end
