function [sinal, tempo ] = DAQ_Parte2(N, Fs)
%devices = daq.getDevices; %Obter 'DeviceID' dos aparelhos instalados

%dispositivo = daq.createSession('ni');
%canal1 = addAnalogInputChannel(dispositivo,'deviceID',channelID,'Voltage'); %a definir 2 e 3
%canal2 = addAnalogInputChannel(dispositivo,'deviceID',channelID,'Voltage'); %a definir 2 e 3
dispositivo.Rate = Fs;       %a definir
dispositivo.DurationInSeconds = 2        %a definir
dispositivo.NumberOfScans = N;      %a definir
canal1.Range = [-60,60]                %a definir
canal2.Range = [-60,60]                %a definir

%[sinal,tempo] = dispositivo.startForeground;

%%%%%%%%%%%%%%%%%%%%%%%%DEBUG%%%%%%%%%%%%%%%%%
%t=(0 : 1/Fs : (N-1)*1/Fs);
%sinal1=10*cos(2*pi*t*103)+100;
%sinal2=10*cos(2*pi*t*103+pi/2)+100;  %%Funcao do nad nao funciona com componentes DC

t=(0 : 1/Fs : (N-1)*1/Fs);
sinal1 = cos(2*pi*100*t); %sinal 1 teste
sinal2 = cos(2*pi*100*t + pi/3); % sinal 2 teste
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%sinal1=sinal(:,[1]);
%sinal2=sinal(:,[2]);


periodo_1 = 1/(frequencia(sinal1, dispositivo.Rate));
Ts= 1/dispositivo.Rate;
lim_1 = 5*(periodo_1/Ts);
lim_1 = round(lim_1);
lim = lim_1;

periodo_2 = 1/(frequencia(sinal2, dispositivo.Rate));
lim_2 = 5*(periodo_2/Ts);
lim_2 = round(lim_2);

if (lim_2<lim_1)
    lim = lim_2;
end
    
time =  0:Ts:lim*Ts-Ts ;

subplot(2,1,1);
plot(time,(abs(sinal1(1:lim))));
xlabel('Tempo');
ylabel('Amplitude');
title(['Frequencia=',num2str(frequencia(sinal1,dispositivo.Rate)),' Dif. de Fase=',num2str(DifFase(sinal1, sinal2, dispositivo.NumberOfScans, dispositivo.Rate)),' Valor eficaz=', num2str(ValorEficaz(dispositivo.NumberOfScans ,dispositivo.Rate,1/periodo_1,sinal1)),'Nº de amostras=',num2str(dispositivo.NumberOfScans),' Fs=',num2str(dispositivo.Rate),' Alcance=',num2str(canal1.Range) ]);

subplot(2,1,2);
plot(time,(abs(sinal2(1:lim))));
xlabel('Tempo');
ylabel('Amplitude');
title(['Frequencia=',num2str(frequencia(sinal2,dispositivo.Rate)),' Dif. de Fase=',num2str(DifFase(sinal1, sinal2, dispositivo.NumberOfScans, dispositivo.Rate)),' Valor eficaz=', num2str(ValorEficaz(dispositivo.NumberOfScans ,dispositivo.Rate,1/periodo_2,sinal2)),'Nº de amostras=',num2str(dispositivo.NumberOfScans),' Fs=',num2str(dispositivo.Rate),' Alcance=',num2str(canal2.Range)]);
end
