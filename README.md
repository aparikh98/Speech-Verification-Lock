# Speech-Verification-Project
I used the idea that each frequency isn’t equally as important for recognizing a speaker (seen in Mel Frequency Cepstral Coefficients) to create a “voice lock” which requires the correct speaker to say a four digit code to unlock it. 

In order to do this, I trained the model using a set of a few different people’s voices as they said each digit. 
We do this by: 
In discrete time, we take overlapping sections of the signal
Each section is converted to the frequency domain using FFT
 The spectrum is then mapped on the Mel Scale and then sampled. The Mel scale is basically linear under 1000 Hz and logarithmic above it. 
 Take the log of the magnitudes and the Discrete cosine transform (which is basically the Fourier transform but only uses real values)
Store these known cepstrum coefficients in a dictionary

Then when a user tries to unlock it, we compute these coefficients and match it to the closest stored signal (basically Euclidean distance between the two vectors)
Here are a few examples of the algorithm at work:
