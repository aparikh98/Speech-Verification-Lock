function codebk = vqCodeBook(d, k)
e = 0.0001;                                 
codebk = mean(d, 2);                       
distortion = int32(inf);             
numOfCentroids = int32(log2(k));            
for i=1:numOfCentroids
    codebk = [codebk*(1+e), codebk*(1-e)];  
    while(1==1)
        dis = distance(d, codebk);            
        [m,ind] = min(dis, [], 2);          
        t = 0;
        lim = 2^i;
        for j=1:lim
            codebk(:, j) = mean(d(:, ind==j), 2);    % updating centroids to better mean values
            x = distance(d(:, ind==j), codebk(:, j));  % x is a cluster i.e vector of neighbouring ...
            len = length(x);                         % ... points of a centroid
            for q = 1:len
                t = t + x(q);
            end
        end
        if (((distortion - t)/t) < e)       % distortion condition breaks the loop
            break;
        else
            distortion = t;
        end
    end
end