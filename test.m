function test(speakers, digits, code)
dist_mins = zeros((speakers * (digits+1)), 1);
correct = 0;
total = 0;
testdir = "recordings/"

for i=1:speakers                       
   for j= 0:digits
    file = sprintf('%s%d_%d_1.wav', testdir, j, i);           
    disp(file)
    [s, fs] = audioread(file);      
    v = mfcc(s, fs);            
    distmin = inf;
    k1 = 0;
    for l = 1:length(code)      
        d = distance(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
        if dist < distmin
            distmin = dist;
            k1 = l;
        end      
    end
    k =((i-1)*(digits+1)+j+1);
    dist_mins(k) = distmin;

    i1 = (k1-j-1)/(digits+1) +1;
    j1 = (1 - i) * digits + k1 - i;
    if i1 == i && j1 == j
        correct = correct + 1;
    else
        msg = sprintf('speaker %d does not match with speaker  %d', i, i1);
        msg1 = sprintf('Or Number %d does not match with Number %d', j, j1);
        msg2 = sprintf('Or file %d does not match with file %d', k, k1);
        disp(msg);
        disp(msg1);
        disp(msg2);
    end
    total = total +1;
   end
end
disp(mean(dist_mins));
disp(std(dist_mins));
disp(max(dist_mins));
disp(min(dist_mins));

msg = sprintf('Accuracy %f', correct/total);
disp(msg)