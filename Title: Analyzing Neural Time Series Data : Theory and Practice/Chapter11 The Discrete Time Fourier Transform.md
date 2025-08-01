# Time Fourier Transform 
3 characteristics of sine waves: 
* frequency: how fast, measured in cycles per second 
* power: is amplitude squared 
* phase: timeing of sine wave, measured in radians or degress 

## Making Waves 
A sin(2πft + θ) <br> 
*f* is the frequency of the sine wave <br> 
*t* is time, it could be space 
*θ* is the phase angle offest, which is related to the value of the sine wave at time=0 <br> 
![image](https://github.com/user-attachments/assets/bf50a02d-c214-4965-a24d-e08917fab343)

The sine wave at each iteration corresponds to a frequency one step slower than that iteration. <br> 
Thus, the first iteration of this loop produces a sine wave of zero frequency, which is called as `DC component` <br> 

`Nyquist theorem` : <br> 
you need at least two points per cycle to measure a sine wave, and thus half the number of points in the data corresponds to the fastest frequence that can be measured in teh data <br> 
`number of unique frequency`: extracted from a time series of length *N* is ****N/2 + 1**** <br> 


$$
X_f = \sum_{k=1}^{n} x_k e^{-i 2\pi f (k - 1)n^{-1}}
$$

`n` refers to the number of data points in vector x <br> 
$X_f$ is the Fouries coefficient of time series variable `x` at frequency `f`  <br>

![image](https://github.com/user-attachments/assets/78f56445-ef45-47fe-b203-45307d8a962a)

![image](https://github.com/user-attachments/assets/c69e05e7-44aa-4433-a6e8-0144c3cefede)

## Inverse Fouries transform 

reconstruct the original time series data with only the frequency domail information <br> 

$$
x_k = \sum_{f=1}^{n} X_k e^{i 2\pi f (k - 1) n^{-1}}
$$

here, it is a sngle multiplication <br> 
don't contain negative sine here <br> 

## Stationarity and the Fourier Transform 
One assumption of the Fourier transform is that your data are stationary. <br> 
violations of stationarity can decrease the peakiness of the results of the Fourier transform. <br> 
![image](https://github.com/user-attachments/assets/a9f089b6-685e-4911-9f97-43d5e982c0e7) 

This is why we need to perform temporally localized frequency decomposition methods, such as wavelet convolution, filter-Hilbert, or short-time FFT <br>.
And the second reason we need to do it, is because the Fourier transform contains all temporal information of the time series data. <br>

## Extracting more or fewer frequencies than data points 
the number of frequencies you get from a Fourier transform is N/2+1, where N is the number of time points in the data, and +1 is for  DCor zero-frequency component. <br> 

But if you want more or fewer frequencies from a Fourier tranform, you can simply add data points to get more frequencies. This is called `zero-padding` <br> 
Zero-padding doesn't increase the amount of information in the data and the frequency precision of the Fourier transform; only the frequency resolution  <br> 

Matlab function `FFT` has an optional second input, FFT(N), which determines the number of frequencies that are extracted. <br> 
By default, N is equal to the number of data points. <br> 
But you can change it, if N is larger than the number of data points, the time series will be zero-padded. <br> 


## The convolution Theorem 

在时域（时间轴上）两个信号的卷积操作，等价于在频域（频率轴上）将它们的傅里叶变换相乘。  <br> 
In the time domain, convolving two signals is the same as multiplying their Fourier transforms in the frequency domain. <br> 

two ways of convolution: 
* flip the kernel backward, slide it along the signal, and compute the dot product at each time step. <br>
* perform convolution is by taking the Fourier transforms of the signal and the kernal, multiplying the Fourier transform together point-by-point. <br>
  
当你对卷积核和信号的傅里叶变换执行逐频率的相乘操作时，其实你是将信号的频率谱按核的频率谱进行缩放。相乘的结果（也就是卷积的结果）就是在核与信号中都共同存在的频率结构。 <br> 
When you perform the frequency-by-frequency multiplication of the Fourier transforms of the kernal and the signal, you are scaling the frequency spectrum of the signal by the frequency spectrum of the kernal. <br> 
the result of multiplication is the frequency structure that is common to both the kernel and the signal <br> 
This is why convolution can be conceptualized as a frequency-domain filter. <br> 
![image](https://github.com/user-attachments/assets/8c3c0fbc-2c37-45b8-9f7a-9eed8fa35ffc)

![image](https://github.com/user-attachments/assets/38a571af-2f25-4548-a5b8-117085a3a3c3)

sine wave is a 50Hz wave; and two Gaussian widths wave is 15Hz and 5 Hz. <br> 
the power spectrum of the narrow Gaussian at 20 Hz overlap slightly with the power spectrum of singe wave; both are non-zero values. <br> 

![image](https://github.com/user-attachments/assets/40fe502d-6602-4eb9-a3c8-9ac6f3220cc5)

The result of convolution must be equal to the length of the signal plus the lengthof the kernel minus one. <br> 
make the inverse FFT return the correct number of time points, and to do this, you will need to make sure to compute the FFTs of the signal and the kernel using the appropraite number of time points <br> 
after computing the inverse Fourier transform, you will need to remove the appropriate number of time points from the beginning and from the end of the time series. <br> 
