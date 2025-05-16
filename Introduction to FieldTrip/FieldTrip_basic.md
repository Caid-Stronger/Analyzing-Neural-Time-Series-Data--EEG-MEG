## FieldTrip Basics 

![image](https://github.com/user-attachments/assets/8466f2eb-a1bd-4e5c-bc75-03d34b8394f0)

the "cfg" argument is a configuration structure

```
cfg.channel = {'C3', 'C4', 'F3', ''F4} #  选择这几个通道分析
cfg.foilim = [1 70] # 设置 频率范围为 1 到 70 Hz
```
```
dataout = functionname(cfg, datain)
functioname(cfg, datain)
dataout = functionname(cfg)
cfg.key1 = value1
cfg.key2 = value2
```

## ft_preprocessing 
```
[data] = ft_preprocessing(cfg) % 直接从文件读取
[data] = ft_preprocessing(cfg, data)  % 对已有数据做进一步浴池里
```

```
cfg = []
cfg.dataset = ' '% 指定数据文件
cfg.bpfilter = True
cfg.bpfilter = [0.01 150] # 设置带通滤波（band-pass filter） 范围 0.1 Hz 到 150 Hz
rawdata = ft_preprocessing(cfg) # 读取并预处理数据，返回

```

## ft_preprocessing 

```
cfg = []
cfg.method = 'mtmfft'
cfg.foilim = [1 120] %frequency of interest limits 感兴趣的频率范围
freqdata = ft_freqanalysis(cfg, rawdata)
freqdata = ft_freqanalysis(cfg, rawdata)  % 对预处理后的数据进行频率分析
```

