function [ Foutput ] = frequencia( sinal_original, Fs )
%Fs Freq de amostragem
%N é o numero de amostras
N=length(sinal_original);
delta_f= Fs/N;


sinal=sinal_original;

%%%Usando lpDFT%%%

%%Calculo da FFT
sinal_f = fft(sinal);

[sinal_f_max, i]=max(abs(sinal_f(2:length(sinal_f)))/N);

if (abs(sinal_f(i+1) ) > abs(sinal_f(i-1) ) ) %%caso da direita ser maior
   kopt = ( imag(sinal_f(i+1) - sinal_f(i)) *sin((2*pi/N)*(i-1) ) + (real(sinal_f(i+1) - sinal_f(i)))*cos( (2*pi/N)*(i-1) ) )/(real(sinal_f(i+1) - sinal_f(i)));
   Z1 = imag(sinal_f(i))*(kopt-cos( (2*pi/N)*(i-1) ))/(sin( (2*pi/N)*(i-1) )) + real(sinal_f(i));
   Z2 = imag(sinal_f(i+1))*(kopt-cos( (2*pi/N)*(i) ))/(sin( (2*pi/N)*(i) )) + real(sinal_f(i+1));
   lambda =(N/(2*pi)) * acos( ( Z2*cos((2*pi/N)*(i))-Z1*cos( (2*pi/N)*(i-1) ))   /   (Z2-Z1) );
   f1=lambda*delta_f
   Foutput=f1;
else
   kopt = ( imag(sinal_f(i) - sinal_f(i-1)) *sin((2*pi/N)*(i-2) ) + (real(sinal_f(i) - sinal_f(i-1)))*cos( (2*pi/N)*(i-2) ) )/(real(sinal_f(i) - sinal_f(i-1)));
   Z1 = imag(sinal_f(i-1))*(kopt-cos( (2*pi/N)*(i-2) ))/(sin( (2*pi/N)*(i-2) )) + real(sinal_f(i-1));
   Z2 = imag(sinal_f(i))*(kopt-cos( (2*pi/N)*(i-1) ))/(sin( (2*pi/N)*(i-1) )) + real(sinal_f(i));
   lambda =(N/(2*pi)) * acos( ( Z2*cos((2*pi/N)*(i-1))-Z1*cos( (2*pi/N)*(i-2) ))   /   (Z2-Z1) );
   f2=lambda*delta_f
   Foutput=f2;
end

f3=i*delta_f - delta_f; %%DEBUG FREQUENCIA ONDE EXISTE O PICO NA FFT
Foutput=round(Foutput);
end
