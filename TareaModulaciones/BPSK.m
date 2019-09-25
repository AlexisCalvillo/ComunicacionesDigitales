%Modulación BPSK
close all;
N=2;
k=log2(N);
n=900000;
xV=randi([0,1],1,n);
dataInMatrix = reshape(xV,n/k,k);   % Reshape data into binary k-tuples, k = log2(M)
simb = bi2de(dataInMatrix);            
xMod=pskmod(simb,N,2*pi/N);
xRec=awgn(xMod,50,'measured');
s=scatterplot(xRec,1,0,'g+');   
hold on;
scatterplot(xMod,1,0,'ro',s),title('QAM16');