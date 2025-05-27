## Why Wavelets 

the reason the Fourier transofrm does not show whether and how the frequency characteristics change over time is that the kernel used in the Fourier transform (a )sine wave 
has no temporal localization <br> 

using one sine wave cycle  is not good, because although the temporal precision is good, the frequency precision is poor <br> 
a "box-car" window around the sine wave is also a poor choice, because it weights all data points in the box-car area equally and it  will produce edge-artifacts in the data. <br> 

### a Guassian taper to window the sine wave 

![image](https://github.com/user-attachments/assets/c6203873-183b-4e01-8a1d-16995f1293b0)

* have no sharp edges that produce artifacts, dampen the influence of surrounding time points on the estimate of frequency characteristics at each time point <br>
* a sine wave windowed with a Guassian is called a Morlet wavelet. <br>

* **wavelet** must have values at or very close to zero at both ends, and they must have a mean value of zero. <br>
* the frequency information obtain at each time point is a weighted sum of frequency information of surrounding time points, with the weighted decreasing with increasing distance away from the center of the wavelet. <br>
* the activity at each time point is an estimate of the instantaneous activity and is influenced by activity from neighboring time points. <br>
* 当你用 Morlet 小波（或其他窗函数）去分析一个信号时，其实不是在“精确地观察某一个时间点”，而是把一个有限长度的波形（比如一个带高斯窗的正弦波）放在这个时间点上，然后和信号做点积。<br>
* ![image](https://github.com/user-attachments/assets/feac8df9-b0fc-42b6-9e1e-c23c0e54f500)

* ## How to make wavelets

* create a sine wave
* create a Gaussian
* multiply them point by point

The frequence of a Morlet wavelet is called its **peak frequency** <br>

The Gaussian Window:

$$
\text{GaussWin} = a e^{-\frac{(t - m)^2}{2s^2}} 
$$

$$
s = \frac{n}{2\pi f}
$$


* a refers to amplitude, the height of Gaussian
* t is time
* m is an x-axis offset(this is not revelant for EEG analysis and can always be set to zero and thus left out of the eq
* f is the frequency
* n refers to the number of wavelet cycles
PS：
1. cannot use frequencies that are slower than epoches. if you have 1s of data, you cannot analyze activity lower than 1Hz. You should have several cycles of activity (if you have 1s of data, use wavelets that are 4Hz and faster) <br>
2. The frequencies of the wavelets cannot be anbove the Nyquist frequency. <br>
3. if you have a wavelet at 15.0 Hz, a wavelet at 14.9 Hz is unlikely to provide any unique information. <br>
![image](https://github.com/user-attachments/assets/1b885071-e9ee-42d7-9cdb-3780152bc048)

## Wavelet Convolution as a Bandpass Filter 

The morlet wavelet that has a peak frequency of 6Hz. And the bandpass filter is from 4Hz to 8Hz. <br> 
a Morlet wavelet is a special case of a bandpass filter in which the frequency response is Gaussian-shaped. <br> 
In other words, wavelet convolution is bandpass filtering. <br> 
![image](https://github.com/user-attachments/assets/6b312cda-5948-412c-8ee2-8d99fa9daebf)
![image](https://github.com/user-attachments/assets/086f76ec-8066-4151-9acf-06830559838e)
![image](https://github.com/user-attachments/assets/1bf42fce-3943-4503-8ec0-75ad79812dc0)

## Limitations of Wavelet Convolution as  Discussed Thus Far 
power and phase information are needed, and these features of the data are not readily apparent in the bandpass-filtered signal. <br>
for time-frequency analyses, power and ohase information are needed, and these features of the data are not readily apparent in the bandpass-filtered signal. <br> 

![image](https://github.com/user-attachments/assets/96f930e1-b0fe-4cfe-a87e-18db0e940c15)

you would have to alignthe wavelet so that it has 0  degree phase lag with the EEG data at thetime opoint of interest and then compute the dot prodcut. This is not what you want --you want to determine the relationship between the wavelet and the EEg data at all time points and all phase lags, not just at some phase lags. <br> 
This is the limitations of real-valued Morlet wavelets, EEG data are convolved with complex Morlet wavelets -- have both a real component and an imaginary component. 
