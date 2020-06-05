%%
train(4,9);
%%test(4,9,ans);
%%
detect(ans, 4, 9, 'recordings/2_3_1.wav', 'recordings/2_2_1.wav', 'recordings/3_4_1.wav', 'recordings/0_1_1.wav');
%%
detect(ans, 4, 9, 'recordings/2_1_1.wav', 'recordings/5_2_1.wav', 'recordings/4_3_1.wav', 'recordings/9_4_1.wav');
%%
detect(ans, 4, 9, 'recordings/2_4_1.wav', 'recordings/3_4_1.wav', 'recordings/4_4_1.wav', 'recordings/9_4_1.wav');
%%
detect(ans, 4, 9, 'recordings/2_1_1.wav', 'recordings/3_1_1.wav', 'recordings/4_1_1.wav', 'recordings/9_1_1.wav');
