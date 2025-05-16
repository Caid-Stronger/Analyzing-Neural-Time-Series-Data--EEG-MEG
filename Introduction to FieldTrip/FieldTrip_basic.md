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

## ft_freqanalysis 

```
cfg = []
cfg.method = 'mtmfft'
cfg.foilim = [1 120] %frequency of interest limits 感兴趣的频率范围
freqdata = ft_freqanalysis(cfg, rawdata)
freqdata = ft_freqanalysis(cfg, rawdata)  % 对预处理后的数据进行频率分析
```

## Keep track of analysis 

```
dataout = functionname(cfg, datain{1), datain{2}, ......)
dataout = data structure  with
dataout.cfg = settings + defaults

ft_analysispipeline(dataout)

```

## Distributed Computing  

```
subj = {'S01.ds', 'S02.ds', ...};  % 多个被试的数据文件名
trig = [1 3 7 9];                  % 多个触发器，代表不同条件

for s = 1:nsubj
for c = 1:ncond
  cfgA{s,c} = [];
  cfgA{s,c}.dataset     = subj{s};               % 设置数据文件
  cfgA{s,c}.trigger     = trig(c);               % 设置触发器值
  cfgA{s,c}.outputfile  = sprintf('raw%s_%d.mat', subj{s}, trig(c));

  cfgB{s,c} = [];
  cfgB{s,c}.dataset     = subj{s};
  cfgB{s,c}.trigger     = trig(c);
  cfgB{s,c}.inputfile   = sprintf('raw%s_%d.mat', subj{s}, trig(c));
  cfgB{s,c}.outputfile  = sprintf('freq%s_%d.mat', subj{s}, trig(c));

end
end

qsubcellfun(@ft_preprocessing, cfgA)
qsubcellfun(@ft_freqanalysis, cfgB)

```


