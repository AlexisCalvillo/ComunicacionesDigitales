close all;
%Tiempo
A=fopen('tone.txt');
senal=fscanf(A,'%f');
senal=senal';
fm=44100;
tm=1/fm;


vt=[0:tm:t];
% %Transformada rápida
fc=fft(senal,length(senal))/length(senal);
% %Normalizada con el valor absoluto
fn=abs(fc);
% %Frecuencias. 1/tm es frecuencia de muestreo
faxis = linspace(-(1/tm)/2,(1/tm)/2,length(senal));
% figure(1);
 subplot(2,1,2);
 plot(faxis,fftshift(fn));
 xlabel('Frecuencia (Hz)');
 ylabel('Amplitud');
% fs=sprintf('La frecuencia de muestreo es %3.2f \n y la frecuencia de la señal es %3.2f',...
%     1/tm,f);
% title(fs);
subplot(2,1,1)
ffts=fftshift(fn);
plot(vt(500:1000),senal(500:1000));
xlabel('Tiempo');
ylabel('Amplitud');
[m,ind]=max(fftshift(fn));
title(sprintf('La frecuencia de la se�al es %3.2f Hz', abs(faxis(ind))));
% grid on;