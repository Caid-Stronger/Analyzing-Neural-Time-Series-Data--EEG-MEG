## Hilbert Transform 

EEG data have the form *Mcos(2Πft)* <br> 
The hilbert transform is another way to extractthe imaginary part. <br> 

* First, compute the Fourier transform of a signal and create a copy of the Fourier coefficients that have been multiplied by the complex operator (i). <br>
  This turns the `Mcos(2mf)` into `iMcos(2mt)`.
* Next, identify the positive and negative frequencies, The `positive frequencies` are those `between but not including the zero and the Nyquist frequencies`,<br>
  and the `negative frequencies` are those `above the Nyquist frequency` (throughout the Hilbert transform, the zero and Nyquist frequenciesare left untouched).
*  The next step is to convert the iMcos(2nf) to iMsin(2m). Remember that cosine and sine are related to each other by one-quarter cycle,<br>
  thus, to convert acosine to a sine, you rotate the positive-frequency coefficients one-quarter cycle counter.<br>
  clockwise in complex space (-90°or -/2)(think about the complex plane: rotating fromthe positive real axis to the positive imaginary axis turns a cosine into a sine).
* Thus, to convert a cosine to a sine in negative frequencies, you rotate the negative-frequency coefficients one-quarter cycle clockwise (90 or π/2). <br>

**Analytic signal **
take the inverse Fouries transform of the modulated Fourier coefficients. <br>
负频率上的成分是冗余的，只是正频率部分的共轭。它们加在一起才让时域变成实数。<br>
解析信号 只需要正频率部分，负频率反而会“污染”我们重建的虚部。<br>
![image](https://github.com/user-attachments/assets/b7e8c128-ceca-4e08-a946-828326e11fd0)
![image](https://github.com/user-attachments/assets/596c52ee-50f6-4124-bc48-212f374a608e)
![image](https://github.com/user-attachments/assets/d68f4c9d-3e3e-4ec0-bbe8-2ddad59b12db)

In practice, Matlab `hilbert` function transform can be computed without explicitly rotating the positive and negative frequency Fourier coefficients, simply by doubling the positive frequency coefficients and zeroing the negative-frequency coefficients. <br> 
![image](https://github.com/user-attachments/assets/91dff2c6-650d-4dca-bdef-fc55733b7d7e)

The Matlab function `hilbert` will accept a matrix as input. This is useful to apply the Hilbert transform to many trials or many electrodes in one command. However, the Matlab `hilbert` function will always compute  the FFT over the first dimension. Thus, you shoule make sure that **the first dimension of your matrix contains time**  <br> 
If you plot only the real part of the Hilbert transform, you will not know whether it was computed on the correct dimension because the Hilbert transform does not affect the real part of the signal. <br> 
A fast and easy method to make sure the `hilbert` function was applied correctly is to plot the phase angles over time <br> 
![image](https://github.com/user-attachments/assets/603c63a0-2686-4f3b-af68-eaf2edf93308)

## Filtering data before applying the Hilbert transform 

the resulting analytic signal may be difficult to interpret because all frequencies present in the data will contribute to the result, and frequencies with more power will contribute more compared to frequencies with the less power. <br> 
**You should filter the data into separate frequency bands before applying the Hilbert transform.** <br> 

## Finite versus infinite impulse response filters 
**Finite impulse response** : FIR 
* FIR filters have a response that ends at some point
* IIR filters have a response that never ends

FIR filters are preferred because FIR filters are more stable and less likely to introduce nonlinear phase distortions <br>

* `bandpass` keep the activity between the specified frequencies
* `band-stop` remove activity between the specified frequencies
* `high-pass` retain high frequencies but attenuate low frequencies
* `low-pass` retain low frequencies but attenuate high frequencies

## Define the filter 
![image](https://github.com/user-attachments/assets/a117ffac-7119-4efe-b56d-3cd4a3b2368d)

create a filter kernel is by specifying the ideal filter shape and  the frequenccies that define that shape <br> 
frequencies are specified as a fraction of the Nyquist frequency <br> 
`firls`: finite impulse response filters via least squares <br>
* first input is `order parameter`, defines the length of the filter kernel(the length of kernel is the order plus one) determines the precision of the filter's frequency response. Larger orders will produce kernels with relatively better frequency precision.
if you want to resolve activity ar a particular frequency, the filter kernel must be long enough to contain at lease one cycle at that frequency. <br>
if the lower frequency bound is 10Hz, the filter kernel must be at least 100ms long. In practice, it is good to have somewhere **between two and five times** the lower frequency bound (between 200 and 500ms for a 10Hz filter) <br>
EEglab uses three times the lower frequency bound as the default order. The order may change as a function of the center frequency of the bandpass filter. In theory, the filter order must bu an even number to exclude a filter representation for the Nyquist frequency. <br>
* the second input is `a vector of frequencies` that defines the shape of the response. For a bandpass filter, use six numbers: zero frequency, the frequency of the start of the lower  transition zone, the lower bound of the bandpass, the upper bound of the bandpass, the frequency of the end of the upper transition zone, and finally the Nyquist frequency. <br>
* the third input is `ideal filter response amplitude`. This is a vector comprising as many numbers as the second input and contains zeros for the frequencies you want to attenuate and ones for the frequencies you want to keep. For a bandpass filter, you can use [0 0 1 1 0 0 ], where the ones correspond to the lower and upper frequency bounds of the bandpass plateau, the first and last zero correspond to the DC and Nyquist frequencies, the second and fifth zeros correspond to the frequency bounds of the transition zones. <br>
The frequency width of the bandpass filter and transition zones defind the trade-off between temporal precision and frequency precision. <br> As the plateau becomes narrower, the frequency precision increase, but this decreases the temporal precision because narrow frequency filters require longer kernels to resolve. <br> 

![image](https://github.com/user-attachments/assets/65b2cef7-4f23-4254-ba12-07130ed4c406)
![image](https://github.com/user-attachments/assets/b2ee9060-b0f4-451d-ab87-f942b389fb2c)

sharp edges in the frequency domain can produce artifacts in the time domain. <br> 
These artifacts take the form of ripples, which can look like oscillations in the time-domian-filtered signal. <br> 
sharp edges can be avoided by using transition zones. <br> 
If you use `firls`, the transition zones should be **between 10% and 25%** of the lower and upper frequency bounds.<br> 
sharper transition zones give a better frequenct response but increase the risk of introducing time-domain ringing artifacts; gentler transition zones decrease the risk of introducing time-domain ringing artifacts but also have less frequency specificity. <br> 
If you are gonna use a transition zone of less than 10%, you should either smooth the filter kernel using a Hann or Hamming window to minimize edge artifacts when the filter is applied to EEG data. <br> 
Also you can increase the order of the filter when using sharp transition zones because the filter kernels will have more time to taper to zero, reducing the edge articfacts. <br> 

`fir1`:a windowed linear phase filter with tight transition zones <br>  

`firls` allows you to defind your obw transition zones. <br> 
`fir1` automatically set the trainsition zones to zero and then smoothes the resulting filter kernel to minimize ringing artifacts.This smoothing effectively creates a nonzero transition zone<br> 
using `firls` with transition zones of zero and then smoothing the resulting filter kernel with `a Hamming window`, you can perfectly reconstruct the filter kernel created by `fir1` <br> 

![image](https://github.com/user-attachments/assets/f7f18d19-4003-4378-bee1-206bfce5a559)
![image](https://github.com/user-attachments/assets/dbdf3c1f-b4c4-4bae-9ba7-0659e6d0549e)


## Check your FIlters 

$$
sse = \sum_{i=1}^{n} (ideal_i - actual_i)^2
$$

`sse` is the sum of squared errors <br> 
`n` is the number of frequencies that were specified in the ideal filter <br> 
`ideal` and `actual` refer to the power spectra of the ideal filter (the third input to the firls function) <br> 
**sse** should be very close to zero. <br> 

![image](https://github.com/user-attachments/assets/c5d64730-1987-4c8e-9312-b5b6549bbb58) 

## Apply the filter to data 

`firls` returna a vector of length N+1, where  N is the order. <br> 
You can use Matlab function `filtfilt`:the inputs are: 
* filter kernel (the output of firls)
* a scalar or vector of weighting coefficients,can be set to 1.0 
* and the data time series.
* output is the filtered data

![image](https://github.com/user-attachments/assets/51b52d00-4cc8-4f1a-8410-3eaa7dca82ce)

![image](https://github.com/user-attachments/assets/adb8cb4d-8db6-4b38-b191-8ba781133407)
these phase delays can be reversed by refiltering the already-filtered data after reversing the filtered data in time. <br> 
filtfilt 的原理是：先用 filter 向前滤波，然后反转信号再向后滤波，从而消除了相位延迟，得到最终没有相位延迟的结果<br> 

## Butterworth Filter 
![image](https://github.com/user-attachments/assets/94f41720-e57f-4304-b31c-96c8ceaf130c)

![image](https://github.com/user-attachments/assets/63bd5f50-dde4-4c62-84a2-98b7d481de6b)
![image](https://github.com/user-attachments/assets/3cab1fc2-e8e8-429e-b4be-219e004b11e3)
![image](https://github.com/user-attachments/assets/985b20d8-f3a3-4196-8630-082763c527ed)
![image](https://github.com/user-attachments/assets/7a0ede66-68f6-4ec7-aae3-dc5de015a8bf)
