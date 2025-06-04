# How the Multitaper Method Works 

Multitaper approach is an extension of th short-time FFT method that is designed to increase the signal-to-noise ration <br> 
of the frequency representation by applying several tapers that have slightly different temporal characteristic(and thus spectral) <br> 

* from the entire trial period, one time segment is extracted
* the data from the time segment are multiplied by a seried of tapers,resulting several tapered time series <br>
the different  tapers concentrate signal in different regions of time
* the FFT of each tapered time series is taken, and resulting spectra are averaged together

 ![image](https://github.com/user-attachments/assets/a00d1750-f125-4ecb-a07e-f5a987973167)

![image](https://github.com/user-attachments/assets/cb9a78c2-6b7a-4516-bd3f-63cb5dc76e49)
![image](https://github.com/user-attachments/assets/e5966e56-694b-42ca-840f-cd9c7814d771)

![image](https://github.com/user-attachments/assets/fe5cc0e9-9b6a-4ab5-ac2f-79916efffc5a)

15.1 / 15.2  use FFT <br> 
16.2 use shot-time FFT <br> 

## The Tapers 

The tapers used for multitaper method are called `discrete prolate soheroidal sequences` can be obtained via the Matlab function `dpss` <br> 
Slepian tapers are orthogonal to each other (that is the dot product of any one taper with any other is 0) <br> 

**frequency smoothing**
* be benificial for higher frequency activity, in which spectrum tends to be broader that at lower frequencies
* be benificial to account for individual differences <br>
  if two subjects in your experiemnt have gamma-band peaks at 50 Hz and 65Hz in the same task, the frequency precision of a complext Morlet wavelet with 10 cycles <br>
  may identify  the tasl-related gamma band activity at the group level
* facilitate the group-level identification of higher frequency activity 


**temporal smoothing** 
* be beneficial in the identification of high frequency activity, particular in cross-subjects group-level averageing <br> 
* increases in the gamma activity occur in bursts that are neither  time-locked nor phase-locked to the time =0 event <br>
those bursts may not survive cross-trial and cross-subject averageing <br>
* facilitate the identification of non-phase-locked gamma-power increases, because those gamma-power bursts will be smoothed over time and thus more easily identifiable and quantifiable <br>

![image](https://github.com/user-attachments/assets/e6b1595f-f027-4405-b5a7-9a4726222a7e)

1. **the number of tapers** that the Matlab function `dpss` will return is computed based on the desired spectral smoothing and the length of the time segment <br> 
2. the product of the desired segment length (in sample points) and frequency bandwidth (as a fraction of the sampling rate) is the second input argument to the Matlab `dpss` function <br> 
the number of tapers will be rounded to the nearest integer <br> 
3. The product of segment length and the desired spectral smoothing can be kept at a constant (generally is kept between 2 and 4) <br> 
or it can be allowed to vary as a function of frequency band <br>

dpss() 的第二个参数，其实是告诉它：你想要多少频率平滑带宽、用多长的时间窗来实现。 <br> 

N：时间窗长度（样本点数）<br>
W：希望的频率平滑带宽（单位是采样率的比例） <br> 
![image](https://github.com/user-attachments/assets/4d651e8e-bec1-41c1-9a32-5f021663f1f1)

## The last taper 

the last taper of teh sequency generally has a relatively poor spectral representation and thus can be omitted from the analysis <br> 
This can be seen by plotting the second output of `dpss`, which is related to the energy in the speficied band and ideally should be close to 1.0 <br> 
This vector typically has n-1 numbers that are close to 1, and a final number that is lower, around 0.7 and 0.8 <br> 
Avoid using that taper <br> 

![image](https://github.com/user-attachments/assets/c59dadd8-505c-4685-aaed-95e9b9bb2c18)
![image](https://github.com/user-attachments/assets/ab57cf87-7500-4de5-a9f6-024bfa046dcc)
![image](https://github.com/user-attachments/assets/cbc20889-4748-4d67-89f3-d5f098107ed8)

* length of time segment
* the number of frequencies that were extracted
* the number of Slepian tapers
* resulting smoothing 
