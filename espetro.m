
function [ magnitude, F] = espetro(sinal_original, Fs)
N = length(sinal_original);
%valor_medio= mean(sinal_original);
sinal=sinal_original;%%-valor_medio;

sinal_f = fft(sinal)/N;
delta_f= Fs/N;
F = (0 : delta_f : Fs/2); 
%% Componente dc tem de ser dividida por dois devido ao seu espectro
%de potencia não ser dividido logo
sinal_f(1)=sinal_f(1)/2;
magnitude=mag2db(2*abs(sinal_f(1:N/2+1)));
end
