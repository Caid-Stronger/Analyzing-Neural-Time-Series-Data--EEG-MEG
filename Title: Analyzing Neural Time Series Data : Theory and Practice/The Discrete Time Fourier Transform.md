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

