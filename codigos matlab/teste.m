n=linspace(-20,20,41);
hd_n = (sin((pi/4)*n));

for i=1:length(n)
    hd_n(i) = hd_n(i)/(n(i)*pi);
end

hd_n(21) = 0.25;

plot(n,hd_n);
grid on;

figure;
stem(n,hd_n);
grid on;