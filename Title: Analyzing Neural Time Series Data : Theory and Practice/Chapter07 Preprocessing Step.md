
# Balance between Signal and Noise 
![image](https://github.com/user-attachments/assets/2be8ea8a-3a89-4783-b836-c415228467ba)

`amplifier saturations` 放大器饱和： <br> 
当放大器接收到的信号强度超过它能处理的最大范围时，输出的信号就会失真，出现不正常的尖峰或者像平台一样的平直波形。 <br> 
When the input signal is too strong for the amplifier to handle, the output becomes distorted, showing abnormal spikes or flat, plateau-like shapes. <br> 

# Creating Epochs

![image](https://github.com/user-attachments/assets/2a756711-5ce5-4517-be02-b6459466ec7c)

`edge artifacts`边缘伪迹是指在数据段开始或结束处，由于滤波或其他处理方法带来的不真实信号 

Edge artifacts result from applying temporal filters to sharp edges such as a step function, and produce a high-amplitude broadband power artifact that can last hundreds of milliseconds. These artifacts will always be present when there are noncontinuous breaks, which happens at the first and last points of the EEG epochs (see Figure 7.2 and Chapter 14). At the first and last points of each epoch, the time series theoretically goes to zero and continues at zero for infinity. Thus, the transition between the outer “zeros” and the real data are sharp edges.

边缘伪迹通常出现在对信号进行时间滤波时，尤其是在处理突然的边界（如阶跃函数）时，滤波器会产生高振幅的宽频噪声伪影，可能持续几百毫秒。<br>
这种现象即使在数据是连续的情况下也会出现，尤其是在每段 EEG epoch 的开始和结束位置。因为在 epoch 的边缘，时间序列理论上是归零的，并无限延伸为零，真实信号与这些“外部零值”之间的过渡是突变的边缘，容易产生伪迹。<br>

lower frequency band -> more buffer zone 
* 0.5 Hz -> several seconds long
* 100 Hz ->a few tens of ms long

**three cycles at the lowest frequence** <br> 
longer epoches -> avoid to expose ICA to the same data more than once <br> 

![image](https://github.com/user-attachments/assets/c22e3e9c-7498-4bfc-8bdc-454025cb4eaa)
epoches too short? -> reflection approach [a measure  of necessity]
* reflection + orginal data + reflection
* but temporal smooothing can cause activity to  leak out of the reflected data and into the time of region interest

**match trial count** 
* select first N trials from each condition, where N is the number of trials in the smallesr condition 
* select trials at random, but need to record which trials were selected
* select trials based on some relevant behavioral or experiment variable such as reaction time

# Filtering
High-pass data should be applied to continuous data and not to epoched data, because the edge artifacts of a 0.5 Hz frequency may lst up to 6s, which is probably longer than your epochs. 

# Spatial Filtering 

* localize a result ->a surface Laplacian or a single dipole
* functional/anatomical distinctions: a topographical feature -> surface Laplacian distributed source imaging
* connectivity analyses

# Referencing electrode 
* averaged mastoids -- the bone behind the ear 耳朵后面的骨头
* earlobes 耳垂
* should not bbe close to an electrode where you expect your main effects
* an averange references is recommended to electrodes places on the neck or face

# Interpolating Bad Electrodes 

![image](https://github.com/user-attachments/assets/651c9bef-98f0-40b5-9606-71ca26774946)

| 情况                            | 建议处理方式         |
| ----------------------------- | -------------- |
| 电极完全平线或信号极端异常                 | 插值             |
| 有噪音但可能有真实信号                   | 先尝试滤波保留        |
| 对空间分析/平均参考等要求严格               | 建议插值以防污染其他通道   |
| 对矩阵秩敏感的分析（如 ICA）              | 减少插值数量或删除该电极   |
| 实验中发现坏电极                      | 暂停实验更换电极优于后期插值 |
| 被试间电极数量不一致可能影响 group-level 分析 | 统一电极数量或记录删减情况  |


| **Situation**                                                       | **Recommended Action**                                  |
| ------------------------------------------------------------------- | ------------------------------------------------------- |
| Electrode is completely flat or shows extremely large noise         | **Interpolate**                                         |
| Electrode has noise but may still contain brain signal              | **Try filtering before interpolating**                  |
| Using spatial filters, Laplacian, or average reference              | **Interpolate to prevent contaminating other channels** |
| Performing rank-sensitive analyses (e.g., ICA, source analysis)     | **Minimize interpolation or consider removing**         |
| Bad electrode detected during recording                             | **Pause experiment and fix/replace electrode**          |
| Inconsistent number of electrodes across subjects in group analysis | **Standardize channel count or document exclusions**    |


