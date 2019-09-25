%BER vs SNR 
close all;                %Tipo de modulación 1:QAM16 2:QAM64 3:BPSK 4:QPSK
k1=6;
k2=4;
k3=1;
k4=2;% Bits por símbolo
EbNoVec = (2:10)';      % Eb/No
spV = 100;              % Símbolos por ventana
berEst1 = zeros(size(EbNoVec)); %Estimación de ber
berEst2 = zeros(size(EbNoVec)); %Estimación de ber
berEst3 = zeros(size(EbNoVec)); %Estimación de ber
berEst4 = zeros(size(EbNoVec)); %Estimación de ber
for n = 1:length(EbNoVec)
    
    snrdB1 = EbNoVec(n) + 10*log10(k1);
    snrdB2 = EbNoVec(n) + 10*log10(k2);
    snrdB3 = EbNoVec(n) + 10*log10(k3);
    snrdB4 = EbNoVec(n) + 10*log10(k4);
    
    numErrs2=0;
    numErrs1=0;
    numErrs3=0;
    numErrs4=0;
    numBits1 = 0;
    numBits2 = 0;
    numBits3 = 0;
    numBits4 = 0;
    
    while numErrs3<200 && numBits2 < 1e5
        
                dataIn1 = randi([0 1],spV,6);
                dataSym1 = bi2de(dataIn1);
                txSig1 = qammod(dataSym1,64);
                dataIn2 = randi([0 1],spV,4);
                dataSym2 = bi2de(dataIn2);
                txSig2 = qammod(dataSym2,16);
                
                dataIn3 = randi([0 1],spV,1);
                dataSym3 = bi2de(dataIn3);
                txSig3 = pskmod(dataSym3,2,pi);
                
                dataIn4 = randi([0 1],spV,2);
                dataSym4 = bi2de(dataIn4);
                %dataInMatrix = reshape(dataIn,4/4,4); 
                %dataSym = bi2de(dataIn);
                txSig4 = pskmod(dataSym4,4,pi/4);
                
        % Pass through AWGN channel
        rxSig1 = awgn(txSig1,snrdB1,'measured');
        rxSig2 = awgn(txSig2,snrdB2,'measured');
        rxSig3 = awgn(txSig3,snrdB3,'measured');
        rxSig4 = awgn(txSig4,snrdB4,'measured');
        
        
                rxSym1 = qamdemod(rxSig1,64);
                % Convert received symbols to bits
                dataOut1 = de2bi(rxSym1,6);
                
                rxSym2 = qamdemod(rxSig2,16);
                % Convert received symbols to bits
                dataOut2 = de2bi(rxSym2,4);
                
                rxSym3 = pskdemod(rxSig3,2,pi);
                % Convert received symbols to bits
                dataOut3 = de2bi(rxSym3,1);
                
                rxSym4 = pskdemod(rxSig4,4,pi/4);
                % Convert received symbols to bits
                dataOut4 = de2bi(rxSym4,2);
                
        
        
        % Calculate the number of bit errors
        nErrors1 = biterr(dataIn1,dataOut1);
        
        % Increment the error and bit counters
        numErrs1 = numErrs1 + nErrors1;
        numBits1 = numBits1 + spV*k1;
        
        
        
        % Calculate the number of bit errors
        nErrors2 = biterr(dataIn2,dataOut2);
        
        % Increment the error and bit counters
        numErrs2 = numErrs2 + nErrors2;
        numBits2 = numBits2 + spV*k2;
        
        
        
        % Calculate the number of bit errors
        nErrors3 = biterr(dataIn3,dataOut3);
        
        % Increment the error and bit counters
        numErrs3 = numErrs3 + nErrors3;
        numBits3 = numBits3 + spV*k3;
        
        
        
        % Calculate the number of bit errors
        nErrs4 = biterr(dataIn4,dataOut4);
        
        % Increment the error and bit counters
        numErrs4 = numErrs4 + nErrs4;
        numBits4 = numBits4 + spV*k4;
    end
    
    % Estimate the BER
    berEst1(n) = numErrs1(1)/numBits1;
    berEst2(n) = numErrs2(1)/numBits2;
    berEst3(n) = numErrs3(1)/numBits3;
    berEst4(n) = numErrs4(1)/numBits4;
end
berTheory1 = berawgn(EbNoVec,'qam',64);
berTheory2 = berawgn(EbNoVec,'qam',16);
berTheory3 = berawgn(EbNoVec,'psk',4,'nondiff');
berTheory4 = berawgn(EbNoVec,'psk',2,'nondiff');
        
semilogy(EbNoVec,berEst1,'*r')
hold on
semilogy(EbNoVec,berEst2,'og')
semilogy(EbNoVec,berEst3,'xb')
semilogy(EbNoVec,berEst4,'.m')
semilogy(EbNoVec,berTheory1,'-r')
semilogy(EbNoVec,berTheory2,'-g')
semilogy(EbNoVec,berTheory3,'-b')
semilogy(EbNoVec,berTheory4,'--m')
grid
legend('Estimated BER','Theoretical BER')
xlabel('Eb/No (dB)')
ylabel('Bit Error Rate')