# Independent Components Analysis 

* clean data by identifying components that isolate artifacts and then subtracting those components from the data
* work as a data  reduction tech by analyzing component time series instead of electrode time series

  ![image](https://github.com/user-attachments/assets/5a030fa3-a2c5-458c-afee-9067c692e50d)
  
**a blink artifact** 
blink artifact has an anterior前叶 distribution, and their time courses are largely flat with  occasional very high-amplitude spikes when their eye muscles close and open. <br> 

two ways to remove blink artifact: 
* ICA
* Regression Technique

**No Suppression of blinking**
* Active suppression of blinking relies on cortical oculomotor networks, which may introduce task-unrelated but stimulus-locked activity in frontoparietal oculomotor circuits.  
* sacrifice attention to the task
* if subjects are permitted to blink during the intertrial interval, then this time period might not be sutable as a baseline for normalization of time-frequency dynamics 


## Oculomotor Activity 

Sources of artifacts: especially ar frontal and laternal frontal eletrodes 前额叶和侧前额叶
* saccades
* microsaccades

**Elimination** 
* having the visual stimuli at a central location on the experiment monitor
* eye tracker
* electrooculogram /ɪlektrəʊˈɒkjʊləɡræm/ 眼动图 

![image](https://github.com/user-attachments/assets/f185caec-48a6-4fb4-9410-9f0aaa412029)

ICA may not be appropriate because if subjects are supposed to be fixating throughout the experiment, this may indicate that the subjects were not fully engaged in te taks on that trial. <br> 


## Removing trials based on EMG in EEG channels  

EMG is noticeable bursts of 20 to 40- Hz activity , often has relatively large amplitude, and is typically maximal in eletrodes around the face, neck and ears. <br> 
If you are analyzing activity above 15 Hz, you should remove them. Even below 15Hz activity, still need to remove trials with large EMG bursts because the subject may have been angaged in activities other than task during the trial <br>

MEG can be removed by ICA, but MEG activity can not include any brain signal activity. <br> 
MEG in in buffer zone for edge artifacts is not necessary to be removed. <br> 

![image](https://github.com/user-attachments/assets/0f8aba8c-d8c4-4e2e-95d1-9dda7f94b351)

## cognitive noise 认知噪声
* remove error trials
* remove trials if they are not asked to reponse to
* first trials after rest
* cognitive  set shift 认知集合转换 / switch cost 切换代价

## Partial error trials 部分错误试次 

Partial errors occur when the subject twitches the muscle of the incorrect response, although he or she pressed the correct button.  <br> 
Correct trials that contain partial errors elicit patterns of brain activity that look more like errors than they do like correct responses. <br>
错误的手发生轻微抽动；反应对，过程有问题；伴有部分错误的正确答案让脑电结果更像是错误翻译

**Elimination**
* First, the Z-transform of the derivative of the EMG signal from each hand is taken and then rectified (that is, taking the absolute value). this eliminates hand- and subject-specific differences in impedance and signal amplitude.
* A partial error is identified when this Z-derivative signal of the hand not used to make the response exceeds two standard deviations (that is, a Z-score of 2) in the time between stimulus onset and the actual button press.
* The magnitude of this EMG peak must be more than two times larger than the largest EMG peak from −300 ms to stimulus onset

* 第一步是对每只手的 EMG 信号的导数进行 Z 转换（标准化），然后取其绝对值。
* 如果“没有按按钮的那只手”的 Z 化导数信号，在刺激出现和实际按键之间的时间段里，超过 2 个标准差，则认为这是一个部分错误。
*  EMG 峰值必须比刺激前 300ms 内的最大 EMG 峰值大两倍以上

![image](https://github.com/user-attachments/assets/febdbce8-f430-4afc-ad5d-dcb48c28b6a6)



