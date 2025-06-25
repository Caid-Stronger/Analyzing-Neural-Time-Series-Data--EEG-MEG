Two approaches for preprocessing: 
1. read all data from the file into memory, apply filters, and subsequently cut the data into interesting segments. <br>
2. identify the interesting segments, read those segments from the data file and apply the filters to  those segments only <br>

The second one is the most approprate for large data set such as the MEGG data <br> 

Three types of sentences: <br>
 In the fully congruent condition (FC) the sentences ended with a high-cloze probability word, <br>
 e.g.,  `De klimmers bereikten eindelijk de top van de berg (The climbers finally reached the top of the mountain)` 

In the fully incongruent condition (FIC) sentences ended with a semantically anomalous word which was totally unexpected given the sentential context, <br>
e.g., `De klimmers bereikten eindelijk de top van de tulp (The climbers finally reached the top of the tulip).`  

The third type of sentences ended with a semantically anomalous word that had the same initial phonemes (and lexical stress) as the high-cloze words from the congruent condition: initially congruent (IC). 

# Dealing with Artifacts 

## How does FieldTrip manage artifacts? 
* rejecting the piece of data containing the artifact <br>
for a short-lived artifact or poorly attached EEG electrode
* subtracting the spation-temporal contribution of the artifact from the data <br>
  using ICA <br>
  
## visual artifact detection 

* ft_rejectvisual : only for segmented data that have already been read into memory <br>
`all channel at once ` <br>
`all trials at once `<br>
`a summary of all channels and trials `<br>
 Using the mouse, you can select trials and/or channels that should be removed from the data. <br>
* ft_databrowser: both for continuous and segmented data <br>
  after detecting the time-segments with the artifacts, call  `ft_rejectartifact` to remove them from data <br>

## Procedure 

* Read the data into MATLAB using `ft_definetrial` and `ft_preprocessing`
* Visual inspection of the trials and rejection of artifacts using `ft_rejectvisual`
* Alternatively you can use ft_databrowser and mark the artifacts manually by interactively paging trial by trial

# Automatic Artifact Rejection 
1. Defining segments of interest using `ft_definetrial`
2. Detecing artifacts using `ft_artifact_zvalue`, which consists of
    `Reading the data (with padding) from disk` <br>
    `Filtering the data` <br>
    `Z-transforming the filtered data and averaging it over channels`
    `Threshold the accumulated z-score`
   

## Reading the data (with padding) from disk 

1. reading from disk
2. reading from memory : have the raw datsstructure that is already segmented in trials
In all cases where we use trial- and filter padding more data is needed, these cannot be applied and you will become much more sensitive to filter issues. <br>

## Filtering the data 
If you know what you are looking for, you can process the data in such a way that it would stand out most. <br> 

## Z-transforming the filtered data and averaging it over channels 

Three characteristics of artifacts: 
1. occur sparsely in time, not all the time
2. they are reflected by larger amplitude than the brain data (possibly or especially in a partticular frequency band)
3. occur over multiple channels

The filtered data is therefore transformed with the following steps: 
1. Per Channel/electrode the amplitude of signal over tiime is calculated (the Hilbert envelop)
2. Per channel/eletrode its mean and standard deviation is calculated (over  all samples)
3. Per channel/electrode every timepoint is z-normalized (mean subtracted and divided by standard deviation)
4. Per timepoint these z-values are  averaged. Since an artifact might occur on any and often on more than one electrode, average z-values over channels/electrodes allow evidence for an artifact to accumulate.

The formulas for calculating the z-scores are:

$$
z_{ch,t} = \frac{x_{ch,t} - \mu_{ch}}{\sigma_{ch}}
$$

where:

$$
\mu_{ch} = \frac{1}{N} \sum_{t=1}^{N} x_{ch,t}
$$

$$
\sigma_{ch} = \sqrt{ \frac{1}{N} \sum_{t=1}^{N} (x_{ch,t} - \mu_{ch})^2 }
$$

- \( N \): total number of time samples  
- \( ch \): channel index  
- \( t \): time index  

In the code this formula is formed such as to optimize the calculation of the channel means and standard deviations.

---

The summation over all channels at each timepoint is performed as:

$$
zsum_t = \sum_{ch=1}^{C} \frac{z_{ch,t}}{\sqrt{C}}
$$

- \( C \): total number of channels

![image](https://github.com/user-attachments/assets/deff3f41-e8b6-45f4-9151-56790eec4127)

## Thresholding the accumulated z-score 

All timepoints that are above or below this threshold will be considered belonging to artifacts <br> 
The lower this threshold thre more conservative the artifact detection will behave, the higher the more liberal. 

`cfg.feedback=yes` you enter an interactive mode where you can browse through the data and adjust the cut-off value
![image](https://github.com/user-attachments/assets/13b21fb2-16ba-4d52-a4dc-05878fcee7ae)

### Artifact padding
When a seties of continuous time points are detected they are considered part of one artifact period and enter the artifact definition as one start and end sample number <br> 
often the artifacts starts a bit earlier and ends a bit later than what the artifact detection is able to capture <br> 
![image](https://github.com/user-attachments/assets/c6aed1f5-4e83-429b-8279-12c29bdf0292)

### Trial padding 
When you want to reject trials with an eye blink right before the trial onset. <br> 
Trial padding pads data on both sides of the trial with the specified length, usch that artifact detecion and rejection is also performed for those padded segments <br> 
![image](https://github.com/user-attachments/assets/ab8f6606-61d7-4ffa-811a-b6a3d5edf2f3)

### Filter Padding 

each artifact type can best be detected with filters of a certain pass band <br>
e.g. pass abnd of 1-15Hz for eye blinks, and 110-140 Hz for muscle artifacts <br>
Filters are known to produce edge effects which can also be detected by artifact-detection routine and mistaken for real artifacts <br> 

To avoid that, filter padding `cfg.artfct.xxx.fltpadding` is used <br> 
Filter padding is used only for filtering, not for artifact detection <br> 

![image](https://github.com/user-attachments/assets/dc587615-3cad-4cd9-9a4f-22bf0635e17a)

### Negative Trialspadding 

Filter artifacts might then still be a problem without th  epossibility of padding the data  (since it is already in memory), therefore you might want to constrain the artifact  detection to a limited part of trial without edges. <br> 

![image](https://github.com/user-attachments/assets/e7090cf3-d31f-474f-9b88-8a40e6d56fbe)

![image](https://github.com/user-attachments/assets/a3983b3d-fd85-4d68-b6db-d065ef956a0d)
The left panel shows the z-score of the processed data, along with the threshold. Data points from the current trial are marked in pink and suprathreshold data points are marked in red. <br> 
 The lower right panel shows the z-score of the processed data for a particular trial, and the upper right panel shows the unprocessed data of the channel that contributed most to the (cumulated) z-score. You can browse through the trials using the buttons at the bottom of the figure. Also, you can adjust the threshold, and manually keep/reject trials. <br> 
In this example data set, a lot of data points are detected to be a ‘jump’ artifact, although they seem more often ‘muscular’ in nature. A typical jump artifact can be seen below: <br>
 ![image](https://github.com/user-attachments/assets/76f75ecb-b46b-4369-a138-6393b65c91ca)

![image](https://github.com/user-attachments/assets/a29d1b49-c8cc-4084-bcc5-552ba1436418)

![image](https://github.com/user-attachments/assets/9a5dd003-2619-4b09-90db-b7335f01081b)


## Cleaning artifacts using ICA 
Independent component analysis (ICA) is a spatio-temporal decomposition strategy that assumes that the underlying sources of the EEG or MEG have a stationary spatial projection to the channels, and are temporally maximally independent. <br> 
the ICA decomposition will only be an approximation of the most visible independent components. <br> 
Following the ICA decomposition we can identify the artifactual components, and backproject all other components to the channel level, excluding the artifacts. <br> 
For efficiency reasons we often do the preprocessing by first identifying the trials of interest and only reading those into memory. However, it might be that certain stereotypical artifacts are more frequent in the inter-trial intervals,for example when the subject was not required to maintain fixation and was more likely to blink or make saccades. Including these inter-trial intervals can therefore contribute to the identification of the eye-related components. <br> 

### Procedure 

1. Read the data with minimal prerpocessing using `ft_preprocessing`
2. remove segmtn with infrequent atypical artifacts using wither `ft_rejectvisual` or `ft_databrowser`
3. ICA decomposition of the data using `ft_componentanalysis`
4. identifying the component that reflect eye and heart artifact using `ft_topoplotIC`
5. removing those components and backprojecting the data using `ft_rejectcomponent`
![image](https://github.com/user-attachments/assets/92f8bd0e-f5dc-4382-b834-39c1b20dabb3)

ICA assumes a mixing of stationary components and cannot estimate more components than the number of channels. If you have a few infrequenct and atypical artifacts, these will be represented in components. <br> 


