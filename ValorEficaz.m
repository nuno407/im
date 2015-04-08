function [VE] = ValorEficaz(N,Fs,f,sinal)
%Determinação do Valor Eficaz de um sinal
%   Detailed explanation goes here

%f=103; %Frequência de Teste
%t=(0 : 1/Fs : (N-1)*1/Fs); %tempo de teste
%sinal = (2 + cos(2*pi*f*t)); %sinal de teste

VE = sinal.^2; %Amostras do sinal ao quadrado (Root)
VE = EstValorMedio(N,Fs,f,VE); %Valor Médio das amostras do sinal ao quadrado (Mean)
VE=sqrt(VE) %Raiz quadrada do Valor Médio das amostras do sinal ao quadrado (Square)

end

