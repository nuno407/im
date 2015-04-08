function [VM] = EstValorMedio( N,Fs, f, sinal )
%Fun��o que estima o valor m�dio
%   Detailed explanation goes here
Nar=N
if (mod(Fs,f) ~= 0) %caso em que existe espalhamento
    npp = Fs/f; %n�pts/per�odo
    npi = fix(N/npp); %n�per�odos inteiros
    Nar = round(npp*npi); %N arredondado
end
%no ciclo if em cima obtem-se um novo N que elimina o espalhamento espetral
%que exitia com o anterior N

s=0;

for i=1:Nar
    s = sinal(i) + s; %Somat�rio das amostras retiradas
end 

VM = s/Nar %Divis�o da soma das amostras pelo n�mero de amostras = Valor M�dio obtido do sinal

end

