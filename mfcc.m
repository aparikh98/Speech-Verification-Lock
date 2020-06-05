function c = mfcc(s, fs)
N = 256;                       
M = 100;                       
len = length(s);
numberOfFrames = 1 + floor((len - N)/double(M));
mat = zeros(N, numberOfFrames); 

for i=1:numberOfFrames
    index = M*(i-1) + 1;
    for j=1:N
        mat(j,i) = s(index);
        index = index + 1;
    end
end
hamW = hamming(N);              
afterWinMat = diag(hamW)*mat;
freqDomMat = fft(afterWinMat);

filterBankMat = melSpectrum(20, N, fs);                
nby2 = 1 + floor(N/2);
ms = filterBankMat*abs(freqDomMat(1:nby2,:)).^2;
c = dct(log(ms));                                
c(1,:) = [];                                     