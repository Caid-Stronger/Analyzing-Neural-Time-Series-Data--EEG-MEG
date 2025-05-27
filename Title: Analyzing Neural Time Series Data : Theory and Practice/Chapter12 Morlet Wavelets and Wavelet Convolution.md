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
* 
