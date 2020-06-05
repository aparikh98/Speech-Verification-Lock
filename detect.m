function detect(code, speakers, digits, file1, file2, file3, file4)
speaker = 4;
codeword = 2349;
 [s, fs] = audioread(file1);
 sound(s,fs);
 pause(0.6);

 v = mfcc(s, fs);            % Compute MFCC's
 distmin1 = inf;
 k1 = 0;
 for l = 1:length(code)      % each trained codebook, compute distortion
 %         disp(size(code{l}));
     d = distance(v, code{l}); 
     dist = sum(min(d,[],2)) / size(d,1);
 
     if dist < distmin1
         distmin1 = dist;
         k1 = l;
     end      
 end
 file1_speak = floor((k1+digits)/(digits+1));
 file1_num = (1 - file1_speak) * digits + k1 - file1_speak;

 [s, fs] = audioread(file2); 
  sound(s,fs);
 pause(0.6);

 v = mfcc(s, fs);            % Compute MFCC's
 distmin2 = inf;
 k2 = 0;
 for l = 1:length(code)      % each trained codebook, compute distortion
%          disp(size(code{l}));
     d = distance(v, code{l}); 
     dist = sum(min(d,[],2)) / size(d,1);
 
     if dist < distmin2
         distmin2 = dist;
         k2 = l;
     end      
 end
 file2_speak = floor((k2+digits)/(digits+1));
 file2_num = (1 - file2_speak) * digits + k2 - file2_speak;

 [s, fs] = audioread(file3);      
  sound(s,fs);
 pause(0.6);

 v = mfcc(s, fs);            % Compute MFCC's
 distmin3 = inf;
 k3 = 0;
for l = 1:length(code)      % each trained codebook, compute distortion
%         disp(size(code{l}));
     d = distance(v, code{l}); 
     dist = sum(min(d,[],2)) / size(d,1);
 
     if dist < distmin3
         distmin3 = dist;
         k3 = l;
     end      
 end
 file3_speak = floor((k3+digits)/(digits+1));
 file3_num = (1 - file3_speak) * digits + k3 - file3_speak;
 
 
 [s, fs] = audioread(file4); 
  sound(s,fs);
 pause(0.6);

 v = mfcc(s, fs);            
 distmin4 = inf;
 k4 = 0;
 for l = 1:length(code)      
 %        disp(size(code{l}));
     d = distance(v, code{l}); 
     dist = sum(min(d,[],2)) / size(d,1);
 
     if dist < distmin4
         distmin4 = dist;
         k4 = l;
     end      
 end
 file4_speak = floor((k4+digits)/(digits+1));
 file4_num = (1 - file4_speak) * digits + k4 - file4_speak;
 
 fprintf('speaker %d, number %d detected\n', file1_speak, file1_num);
 fprintf('speaker %d, number %d detected\n', file2_speak, file2_num);
 fprintf('speaker %d, number %d detected\n', file3_speak,file3_num );
 fprintf('speaker %d, number %d detected\n', file4_speak, file4_num);
 auth = false;
 if (((distmin1 > 5 || distmin2> 5 || distmin3> 5 || distmin4 >5) && distmin1 + distmin2 + distmin3 + distmin4 > 15 )|| (file1_speak ~= file2_speak || file2_speak ~= file3_speak || file3_speak ~= file4_speak))
     disp("Error speaker not recognized");
 elseif  (file1_speak == speaker && file2_speak == speaker && file3_speak == speaker && file4_speak == speaker)
     fprintf("Speaker validated; speaker %d detected\n", (file1_speak + file2_speak + file3_speak +file4_speak)/4);
      auth = true;
 else
     fprintf("Invalid speaker; speaker %d detected\n", (file1_speak +file2_speak+  file3_speak + file4_speak)/4);

 end
 
 code_entered = file1_num *1000 + file2_num*100 + file3_num * 10 + file4_num;
 msg = sprintf('Code entered: %d', code_entered);
 disp(msg);
 if (code_entered == codeword && auth)
     disp("Code authenticated");
 else
     disp("Invalid")
 end
%{

[s, fs] = audioread(file1);      
v1 = mfcc(s, fs);            
[s, fs] = audioread(file2);      
v2 = mfcc(s, fs);            
[s, fs] = audioread(file3);      
v3 = mfcc(s, fs);            
[s, fs] = audioread(file4);      
v4 = mfcc(s, fs);
l1 = ((speaker-1)*(digits+1)+floor(codeword/1000)+1);
l2 =  ((speaker-1)*(digits+1)+mod(floor(codeword/100), 10)+1);
l3 =  ((speaker-1)*(digits+1)+mod(floor(codeword/10), 10)+1);
l4 =  ((speaker-1)*(digits+1)+mod(codeword,10)+1);

D1 = distance(v1, code{l1});
dist1 = sum(min(D1,[],2)) / size(D1,1);
D2 = distance(v2, code{l2});
dist2 = sum(min(D2,[],2)) / size(D2,1);
D3 = distance(v3, code{l3});
dist3 = sum(min(D3,[],2)) / size(D3,1);
D4 = distance(v4, code{l4});
dist4 = sum(min(D4,[],2)) / size(D4,1);
avg_test = 3.4571;
std_test = 0.9152
stds_away1 = (dist1 - avg_test)/std_test
stds_away2 = (dist2 - avg_test)/std_test
stds_away3 = (dist3 - avg_test)/std_test
stds_away4 = (dist3 - avg_test)/std_test
if (stds_away1 < 0 && stds_away2 <0 && stds_away3 <0 && stds_away4 <0)
    disp("Authenticated");
else
    disp("ERROR");
end
%}



