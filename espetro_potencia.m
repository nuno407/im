function [ magnitude, F] = espetro_potencia(sinal, Fs)
N = length(sinal)

f=frequencia( sinal, Fs );
Nar=N;
if (mod(Fs,f) ~= 0) %caso em que existe espalhamento
    npp = Fs/f; %nºpts/período
    npi = fix(N/npp); %nºperíodos inteiros
    Nar = round(npp*npi);
end
%no ciclo if em cima obtem-se um novo N que elimina o espalhamento espetral
%que exitia com o anterior N



sinal_f = fft(sinal, Nar)/Nar;
sinal_f=sinal_f(1:Nar/2+1);

delta_f= Fs/Nar;
F = (0 : delta_f : Fs/2); 
%%Transformar em espectro de potencia
sinal_f_pwd= (abs(sinal_f).^2);
%Transformar para Single side

sinal_f_pwd(2 : length(sinal_f_pwd)-1)=2*sinal_f_pwd(2 : length(sinal_f_pwd)-1);

magnitude=((sinal_f_pwd) );

end
