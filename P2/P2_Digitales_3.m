 recObj= audiorecorder;
 disp('Inicia la grabacion');
 recordblocking(recObj,5);
 disp('Termino la grabacion');
 play(recObj);
 y = getaudiodata(recObj);
plot(y);

tm= 5/length(y);
%Transformada rápida
fc=fft(y);
%Normalizada con el valor absoluto
fn=abs(fc);
%Frecuencias. 1/tm es frecuencia de muestreo
faxis = linspace(-(1/tm)/2,(1/tm)/2,length(y));

plot(faxis,fftshift(fn));
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');

grid on;

[a, fmax]= max(ffshift(fn));
disp('Frecuencia maxima (Hz)');
disp(faxis(fmax));
