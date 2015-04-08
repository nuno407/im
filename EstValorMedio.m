function [VM] = EstValorMedio( N,Fs, f, sinal )
%Função que estima o valor médio
%   Detailed explanation goes here
Nar=N
if (mod(Fs,f) ~= 0) %caso em que existe espalhamento
    npp = Fs/f; %nºpts/período
    npi = fix(N/npp); %nºperíodos inteiros
    Nar = round(npp*npi); %N arredondado
end
%no ciclo if em cima obtem-se um novo N que elimina o espalhamento espetral
%que exitia com o anterior N

s=0;

for i=1:Nar
    s = sinal(i) + s; %Somatório das amostras retiradas
end 

VM = s/Nar %Divisão da soma das amostras pelo número de amostras = Valor Médio obtido do sinal

end

