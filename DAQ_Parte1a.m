
function [sinal, tempo ] = DAQ_Parte1a(N, Fs)

%dispositivos = daq.getDevices %Obter 'DeviceID' dos aparelhos instalados

%prompt = 'Qual é o id do despositivo ';
%id = input(prompt);
%prompt = 'Qual é o canal_id do despositivo ';
%canal_id = input(prompt);

%dispositivo = daq.createSession('ni'); %%national intruments
%canal = addAnalogInputChannel(dispositivo,id ,canal_id,'Voltage'); %a defenir 2 e 3

dispositivo.Rate = Fs;       %a defenir
          %s.DurationInSeconds = 2        %a defenir
dispositivo.NumberOfScans = N;      %a defenir
canal.Range = [-60,60];                 %a defenir

%[sinal, tempo] = dispositivo.startForeground;

%%%%%%%%%%%%%%%%%%%%%%%%DEBUG%%%%%%%%%%%%%%%%%
t=(0 : 1/Fs : (N-1)*1/Fs);
sinal=2*sqrt(2)*cos(2*pi*t*103)+2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Frequencia =(frequencia(sinal, dispositivo.Rate));
Ts= 1/dispositivo.Rate;
time = 0:Ts:4*1/Frequencia+Ts;

subplot(2,1,1);
plot(time,sinal( 1 : length(time) ) );
xlabel('Tempo');
ylabel('Amplitude');
title(['Frequencia=',num2str(Frequencia),' Valor Médio=', num2str(EstValorMedio(dispositivo.NumberOfScans ,dispositivo.Rate,Frequencia,sinal)),' Nº de amostras=',num2str(dispositivo.NumberOfScans),' Fs=',num2str(dispositivo.Rate),' Alcance=',num2str(canal.Range),' Valor eficaz=', num2str(ValorEficaz(dispositivo.NumberOfScans ,dispositivo.Rate,Frequencia,sinal)) ]); 


[magnitude, F]=espetro_potencia(sinal, dispositivo.Rate);

subplot(2,1,2);
plot(F, magnitude);
ylabel('Magnitude(db)');
xlabel('Frequência');
title('Espectro S-D' );
end
