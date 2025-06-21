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



  
  

  
