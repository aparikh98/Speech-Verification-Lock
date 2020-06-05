function code = train(speakers, digits)
k = speakers * (digits +1);                         
disp(k)
traindir = "recordings/"

for i=1:speakers                      
    for j= 0:digits
        file = sprintf('%s%d_%d_0.wav', traindir, j, i);           
        disp(file);
        [s, fs] = audioread(file);
        v = mfcc(s, fs); 
        disp((i-1)*(digits+1)+j+1);
        code{((i-1)*(digits+1) + j+1)} = vqCodeBook(v, k);  
    end
end