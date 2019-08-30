close all;
%Tiempo
t=5;
%Frecuencia de la señal
f=50;
%Tiempo muestreo
tm=0.01;
ct=@(t) 3*sin(2*t*pi*f);
%Vector de tiempos
vt=[0:0.001:t];
%Transformada rápida
fc=fft(ct(vt),length(vt))/length(vt);
%Normalizada con el valor absoluto
fn=abs(fc);
%Frecuencias. 1/tm es frecuencia de muestreo
faxis = linspace(-(1/tm)/2,(1/tm)/2,length(vt));
figure(1);
subplot(2,1,2);
plot(faxis,fftshift(fn));
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
fs=sprintf('La frecuencia de muestreo es %3.2f \n y la frecuencia de la señal es %3.2f',...
    1/tm,f);
title(fs);
subplot(2,1,1)
plot(vt,ct(vt));
xlabel('Tiempo');
ylabel('Amplitud');
title(sprintf('Seno con frecuencia %3.2f Hz', f));
grid on;

%plot(vt,ct(vt))