# The Wavelet Complex 

complex wavelet = corkscrews螺旋线 <br> 
a complex number ` a + ib` <br> 

![image](https://github.com/user-attachments/assets/f43ca8a0-828f-4dfb-9c55-e2c55c5ffe92)
![image](https://github.com/user-attachments/assets/6a70577b-6ee9-4c85-8f8c-fd511a4973f5)

# Polar Notation 极坐标
![image](https://github.com/user-attachments/assets/fee14fce-d444-4470-a7de-5f33748a2113)

M：模长 magnitude，点离原点的距离  <br>
θ：角度（这个点和实轴的夹角） <br> 

M=8.9443 <br>
θ=−1.107 弧度（约为 −63.43°）<br> 

---

$$
M = \sqrt{real^2 + imag^2}
$$

$$
\theta = \arctan\left(\frac{imag}{real}\right)
$$

---

$$
real + imag = M \cos(\theta) + M \sin(\theta)
$$

$$
real + imag = M[\cos(\theta) + \sin(\theta)]
$$

$$
a + ib = M[\cos(\theta) + i \sin(\theta)]
$$

---

## Euler's Formula 

$$
Me^{i\theta} = M \left[ \cos(\theta) + i \sin(\theta) \right]
$$

θ is the angle <br> 

$$
4-8i = 8.9443e^{-1.107i}
$$

the real part of the wavelet corresponds to a cosine wave <br>
and the imaginary part of the wavelet corresponds to sine wave. <br> 
There is a phase difference of π/2 between them, which makes the wavelet appear "asymmetric" or "lopsided." <br>
This is a common structure in complex waveforms and is not an anomaly. <br> 

### For the equation:
$$
\text{cmw} = Ae^{-\frac{t^2}{2s^2}} \cdot e^{i2\pi ft}
$$

We have:

- The first term $e^{-t^2 / 2s^2}$: is a **Gaussian**, responsible for localization (controls the time range).
- The second term $e^{i2\pi ft}$: is a **complex sine wave**.

---

### Euler's formula:

Euler's formula is:

$$
e^{i\theta} = \cos(\theta) + i\sin(\theta)
$$

If we substitute $\theta = 2\pi ft$ into this formula, we get:

$$
e^{i2\pi ft} = \cos(2\pi ft) + i\sin(2\pi ft)
$$

This explains why the real part of the complex Morlet wavelet is a cosine wave and the imaginary part is a sine wave.

𝑓：是小波的 中心频率（或“峰值频率”），它决定你希望检测/分析信号中哪一段频率成分。<br>
𝑡：是时间变量，这意味着小波会在时间域内滑动，用来捕捉某一频率在不同时刻的存在程度。<br>
2𝜋𝑓𝑡：这是将频率转换为角频率的标准写法，是傅里叶和波形分析中的经典结构。 <br>


$$
A = \frac{1}{(s\sqrt{\pi})^{1/2}}
$$


The scaling factor 
𝐴 is a normalization factor used to ensure that wavelets maintain consistent energy across different frequencies. Why is this needed?<br>
* Wavelets at different frequencies have different widths, so their energy (mean squared amplitude) may vary.<br>
* The factor A ensures that wavelets, regardless of frequency, have comparable scale and energy units, making them suitable for comparison. <br> 

![image](https://github.com/user-attachments/assets/1be3e475-1d1f-4ef8-a0bd-90bdf6c69fba)
![image](https://github.com/user-attachments/assets/3985c59e-55b6-4a44-a0e3-16812837516a) 

when the dot product with the real-valued wavelet from figure 12.7D was lessthan zero, the dot product with the complex wavelet has the vector pointing to the lef(negative on the real axis and close to zero on the imaginary axis). <br> 
when the dot product with the real-valued wavelet was zero, the dot product with the complex wavelet has a vector pointing down (zero on the real axis and negative on the imaginaryaxis). <br>
Finally, when the dot product with the real-valued wavelet was positive, the dot prod.uct with the complex wavelet has a vector pointing toward the right (positive on the realaxis and zero on the imaginary axis). <br> 

the result of dot products with the real-valued wavelet maps onto the real axis in the result of dot products with complex wavelets; <br>
the imaginary axis is ignored in the dot product with the real-valued wavelet.<br>

![image](https://github.com/user-attachments/assets/41bbad06-e4c1-4397-9f54-134317122e03)
![image](https://github.com/user-attachments/assets/530d15bd-53a0-4a9c-bfe0-7a7ccb552912)

THe more wavelet and the one cycle sine wave overlap, the mlonger is the line in complex space. <br> 
The length of the line provides information regarding the similarity or overlap between the kernel and the signal. <br> 
the phase relationship between the kernel and the signal is characterized by the angle of the vector. <br> 

* the projection onto the real axis is the bandpass-filtered signal. it can be negative or positive, depending on the phase relationship between the kernel and the signal <br>
* the magnitude of the vector from the origin to the point in complex space defined by the result of the dot product. <br> The length of this vector is related to the similarity or overlap between the kernel and the signal. <br>
when the EEG data contain a lot of energy at 15 Hz, the result of a dot product with a 15 Hz complex wavelet will produce a point in complex place that is far away from the origin. <br> The length of the vector is called the amplitude, and the length squared is called the power.
<br> This is the instantaneous power at the point in time corresponding to the center of the wavelet with respect to the EEG data, and at the peak frequency of the wavelet. 
*  
  
when calculating large matrices, multiplying the complex vector by its conjugate is faster. <br> 

![image](https://github.com/user-attachments/assets/04a2e224-f697-423d-8afa-33c3835e5b4d) 
![image](https://github.com/user-attachments/assets/b04ea9d5-dfc7-4567-8b33-a4ef6a064ec4)

##  How high should the frequency be 
![image](https://github.com/user-attachments/assets/f4292d4f-da1c-4c05-b7b7-1e2406c509e9)

In practice, if the sample rating is 500 Hz, you can use a maximum frequency of 125 Hz `four sample points per cycle` 

## How many frequency should we use 
![image](https://github.com/user-attachments/assets/a8b217a5-8791-44e0-862d-dd21f1f55987)

specify the peak frequencies of wavelets to increase linearly (5, 13, 22, 30 Hz) or logarithmically (5， 9， 16.5， 30 Hz)  <br> 

if the main results concern lower-frequency activity, it is advisable to use logarithmic scaling  <br> 
if the main results concern higher-frequency activity, it is advisable to use linear scaling  <br> 
`imagesc(EEG.times, frequencies, tf_data)`
Matlab function `image` will automaticallly scale y-axis in linear increments.<br> 
if use logarithmic increments, please not enter the second input, leave it blank <br> 


## How long should  wavelet be 
![image](https://github.com/user-attachments/assets/fadd73e4-03b6-48c3-bb24-31ef044f7c81)
make the wavelet centered in time  creating the wavelet using a time vector from a negative  to  a positive number. <br> 

## How many cycles should be used for the Gaussian Taper 
the number  of cycles of Gaussian taper defines its width, which in turn defines the width pf the wavelet. <br> 
a larger number of cycles gives you better frequency precision at the cost of worse temporal precision <br> 
a smaller number of cycles gives you better temporal precision at the cost of worse frequency precision <br> 
`Heisenberg uncertainty principle` :the more you know about when something happened, the less you know about where it happened <br> 

![image](https://github.com/user-attachments/assets/933c6ad9-5345-4cee-9ace-98560795375f)

* three cycle wavelet is better suited for detecting transient activations and is more precise at localizing dynamics in time <br>
* seven cycle wavelet is more sensitive to longer  activations ar specific frequencies; and is more precise at determining the frequency of dynamics <br>

![image](https://github.com/user-attachments/assets/a32610ed-7814-4561-8f56-c09cbe36058c)
13.14A shows the results of convolution with three-cycle wavelets, which maximaize the temporal precision. <br> There  seem to be two power increases, one at **390**ms, and one at **600ms**, that span a fairly broad lower frequency range, from around 3Hz to 12Hz. <br> 
There seem to be several pulses of power suppression that span frequencies of 17Hz to 35Hz. <br>
13.14B shows the  results of a vconvolution with the same EEG data and wavelets with the same peak frequencies, but this time with 10 cycles. <br> 
these results highlight slightly different features of the same data. The two seperate low-frequency peaks have joined together, but it now can be seen that there are power increases in two distinct frequency bands, one in the theta range and one in the upper alpha range. <br> 
The pulse of beta-band power suppression have congealed into a temporally sustained response. <br> 

至少使用3个周期，最多不超过14个，如果使用7个周期及以上，注意确保wavelet 窗口的边缘已经到0 <br> 

## FWHM (full width at half-maximun)

the extent to which neighboring frequencies contribute to the result of wavelet convolution <br> 

![image](https://github.com/user-attachments/assets/1b996138-d7b2-4f6c-92bf-a9c821a52228)

FWHM 越大：<br>
频率“模糊”越强；<br>
说明小波“吃进了”更多邻近频率 → 频率精度差，但 时间定位更好。 <br>

FWHM 越小： <br>
频率定位更精确； <br>
但小波持续时间会变长，时间分辨率降低。  <br>

实际操作建议（更推荐）： <br>
归一化小波的频谱响应（功率范围从 0 到 1）； <br>
找出两侧（在主峰左右）功率刚好为 0.5 的两个频率点； <br>
两点频率相减，就是 FWHM。 <br>
![image](https://github.com/user-attachments/assets/b1e2ec7b-808a-4ac9-9cc6-81e92f772be1)
![image](https://github.com/user-attachments/assets/5803fa1a-4615-4c25-b5c3-47a5bbcf4f30)

