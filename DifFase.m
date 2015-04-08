function [ df ] = DifFase(sinal1, sinal2, N, Fs )
%Estimativa da Diferença de Fase
%   Detailed explanation goes here
%t=(0 : 1/Fs : (N-1)*1/Fs);
%sinal1 = cos(2*pi*100*t); %sinal 1 teste
%sinal2 = cos(2*pi*100*t + pi/3); % sinal 2 teste

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ATENCAO SE HOUVER COMPONENTE DC ESTA FUNCAO VAI COM OS PORCOS!!!!!!!
%%%%% O NAD E FRACO BASICAMENTE!!! :D

sinal_f1 = fft(sinal1);
[Am1 imax1] = max(abs(sinal_f1)/N);
a1 = angle(sinal_f1(imax1))

sinal_f2 = fft(sinal2);
[Am2 imax2] = max(abs(sinal_f2)/N);
a2 = angle(sinal_f2(imax2))

df = (a1 - a2)*180/pi



end

