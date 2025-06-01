# How the short-time FFT works 

use the FFT to extract the frequency structure of brief segments of data (time windows) <br> 
![image](https://github.com/user-attachments/assets/51aa80be-6937-4b23-ba57-d45da3f2a89a)
![image](https://github.com/user-attachments/assets/b21f9472-d714-42e4-87b4-ad4bb241c492)

## Tap the time series 

before computing teh Fouries transform of each time segment, you should taper the data in that segment .<br> 
* Hann: advantageous, because it tapers the data fully to zero at the beginning and end of the time segnemtns .<br> 
* Hamming: but it is narrow , which may excessively taper the data 
* Gaussian: 
![image](https://github.com/user-attachments/assets/f2500b3c-374b-49c6-82d1-81febfa42152)

the numbers of frequencies returned by the FFt is equal `N/2+1` 
* where N is the number of time points in each time  segment <br>
if you have segments that are 500ms long and the sampling rate is 1000Hz, the FFT at each time segment will contain 250 frequencies soaced between zero and 500 Hz. <br>
Thus, you can select the only frequencies you want to analyze. <br>
for example, from 4 Hz to 60 Hz in 30 steps("the requested frequencies") <br>

![image](https://github.com/user-attachments/assets/5c312fbe-b14b-4ec5-8b04-f65993ee6a54)

how to extract the requested frequencies: 
* the single closet frequency bin to each requested frequency
* take the average of several frequency bins surrounding each requested frequency
*average Gaussian-weighted neighboring frequencies: make the results from the short-time FFT method more similiar to the results

**need to creat longer epochs:** <br>
if you want to estimate power at -200ms, you might need the epochs to start at -600ms(assuming a time segment length of 800ms for lower frequencies) <br> 
![image](https://github.com/user-attachments/assets/64edc8b5-61fa-493a-93e6-e7f423aace3a)

## Time Segment Lengths and Overlap 

The larger the time segment, the more frequencies can be extracted, and thus the greater the frequency resolution. <br> 
The temporal resolution is always defined by the data sampling rate and thus does not depend on the length of time segment.<br> 
较短的时间段可以提供更好的时间精度，但代价是频率精度和频率分辨率的降低；而较长的时间段则可以提供更好的频率精度和分辨率，但代价是时间精度的降低。<br> 
![image](https://github.com/user-attachments/assets/ef15b363-424c-477e-99e1-a0e53500afc2)

时间段必须足够长，至少能涵盖最低频率的一个周期，最好能涵盖多个周期以提高信噪比。例如，如果你希望分析3Hz的活动，那么窗口长度至少要为333毫秒；<br>
更好的是667毫秒或999毫秒，这样能覆盖两个或三个周期（时间段长度不必是周期的整数倍）。<br>
另一方面，999毫秒的长度可能太长，以至于会把瞬时的高频活动平均掉，从而错过这些信息。<br> 
为了让短时傅里叶变换方法适应这种时间精度与频率精度的权衡关系随频率而变的特性，你可以根据频率改变时间段的长度：较低的频率使用较长的时间段，而较高的频率使用较短的时间段。这种做法类似于小波卷积中高斯宽度随频率而变的机制。

在这种方法中，FFT 会围绕每个时间点多次执行，每次用不同长度的时间段。每次执行 FFT 时，都会提取一系列频率。<br>
例如，以300毫秒为中心时间点，第一次 FFT 可在−100到+700毫秒的数据段上执行，以提取4到20Hz的频率；下一次 FFT 可在0到600毫秒的数据段上执行，以提取20到40Hz的频率；<br>
以此类推。这是一个简化的示例；你也可以为每个目标频率单独设置时间段长度。<br>

短时傅里叶变换的第二个参数是连续时间段之间的重叠量。设置时间上的重叠具有三个优点：<br>

* 高时间精度；<br>
* 降低加窗造成的信号损失；<br>
* 平滑时频图，使得观察时间变化过程更容易。<br>

虽然没有硬性规则，但通常接受的重叠率为50%到90%。例如，对一个300毫秒的时间段，每75毫秒滑动一次，就相当于有75%的重叠。<br>

## Power and Phase 
![image](https://github.com/user-attachments/assets/1b0a2c42-09ed-4463-b04d-c29f3187778f) 

* overlap between successive time segments
* how many frequencies were  extracted
* whether the time segment length changed as a function of requested frequency
* whether neighboring frequencies were  averaged together to increase signal-to-noise ration
* which function was used to taper teh data
  
