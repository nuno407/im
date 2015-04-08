
function [sinais, tempo ] = DAQ_Parte1b(N, Fs, n_aquisicoes)

%dispositivos = daq.getDevices %Obter 'DeviceID' dos aparelhos instalados

%prompt = 'Qual é o id do despositivo ';
%id = input(prompt);
%prompt = 'Qual é o canal_id do despositivo ';
%canal_id = input(prompt);

%dispositivo = daq.createSession('ni'); %%national intruments
%canal = addAnalogInputChannel(dispositivo,id ,canal_id,'Voltage'); %a defenir 2 e 3
dispositivo.Rate = Fs ;      %a defenir
          %s.DurationInSeconds = 2        %a defenir
dispositivo.NumberOfScans = N ;     %a defenir
canal.Range = [-60,60]                 %a defenir

%Primeira aquisição

%[sinal, tempo] = dispositivo.startForeground;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DEBUG%%%%%%%%%%%
t=(0 : 1/Fs : (N-1)*1/Fs);
sinal=sqrt(2)*2*cos(2*pi*t*10)+2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sinais=zeros(n_aquisicoes,length(sinal));

[magnitude, F]=espetro_potencia(sinal, dispositivo.Rate);
total = zeros(1,length(magnitude));
total=total+magnitude;
for k=1 : length(sinal) 
        sinais(1,k)=sinal(k);
end

for i=(2:n_aquisicoes)
    sinal_i=sqrt(2)*2*cos(2*pi*t*10+i/10)+2;  %[sinal_i, tempo_i] = dispositivo.startForeground;
    [magnitude_i, F_i]=espetro_potencia(sinal_i, dispositivo.Rate);
    total=total+magnitude_i; 
    for k=1 : length(sinal_i) 
        sinais(i,k)=sinal_i(k);
    end
end

total=total/n_aquisicoes;


Frequencia = (frequencia(sinal, dispositivo.Rate));
Ts= 1/dispositivo.Rate;
time = 0:Ts:4*1/Frequencia+Ts;
%%Escolhe-se mostrar apenas a primeira aqisição
subplot(2,1,1);
plot(time,sinal( 1 : length(time) ) );
xlabel('Tempo');
ylabel('Amplitude');
title(['Nº de amostras=',num2str(dispositivo.NumberOfScans),' Fs=',num2str(dispositivo.Rate),' Alcance=',num2str(canal.Range),' Valor eficaz=', num2str(ValorEficaz(dispositivo.NumberOfScans, dispositivo.Rate, Frequencia, sinal)), ' Valor eficaz ruido=', num2str(-999999), ' ENOB=', num2str(ENOB(sinal, dispositivo.Rate)) ]); 



subplot(2,1,2);
plot(F, total);
ylabel('Magnitude(db)');
xlabel('Frequência');
title('Espectro S-D' );%%%%%%%%

end
