%% Reading continuous EEG data into memory 
cfg = [] 
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr';
data_eeg = ft_preprocessing(cfg)

chansel = 1 
plot(data_eeg.time{1}, data_eeg.trial{1}(chansel, :)) 
xlabel('time (s)') 
ylabel('channel amplitude (uV)') 
legend(data_eeg.label(chansel))

%% Preprocessing, filtering and referening 
cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr';
cfg.reref = 'yes'; % do the reference chaneel 
cfg.channel = 'all';  % to all channels 
cfg.implicitref = 'M1';  % the implicit (non-recorded) reference channel
cfg.refchannel = {'M1', '53'};
% the average of these two is used as the new reference
% channel '53' corresponds to the right mastoid (M2)
data_eeg = ft_preprocessing(cfg); 

% name the channel with the name ‘53’ located at the right mastoid to ‘M2’
chanindex = find(strcmp(data_eeg.label, '53')); 
data_eeg.label{chanindex} = 'M2' 


%% discard the channel we do not need 
cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr';
cfg.channel = [1:61 65];   %keep channels 1 to 61 and the newly inserted M1 channel
data_eeg = ft_selectdata(cfg, data_eeg); 
plot(data_eeg.time{1}, data_eeg.trial{1}(1:3, :)); 
legend(data_eeg.label(1:3));

%% read the data for the horizontal EOG 

cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr'; 
cfg.channel = {'51', '60'} 
cfg.reref = 'yes' 
cfg.refchannel = '51' 
data_eogh = ft_preprocessing(cfg)
figure
plot(data_eogh.time{1}, data_eogh.trial{1}(1,:));
hold on
plot(data_eogh.time{1}, data_eogh.trial{1}(2,:),'g');
legend({'51' '60'});

%% select the horizontal EOG channel and discard the dummy channel.
data_eogh.label{2} = 'EOGH';

cfg = [];
cfg.channel = 'EOGH';
% nothing will be done, only the selection of the interesting channel
data_eogh   = ft_selectdata(cfg, data_eogh); 

%% The processing of the vertical EOG is done similar
% using the difference between channel 50 and 64 as the bipolar EOG 
cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr'; 
cfg.channel    = {'50', '64'};
cfg.reref      = 'yes';
cfg.refchannel = '50'
data_eogv      = ft_preprocessing(cfg);

data_eogv.label{2} = 'EOGV';

cfg = [];
cfg.channel = 'EOGV';
% nothing will be done, only the selection of the interesting channel
data_eogv   = ft_preprocessing(cfg, data_eogv); 

%% have the EEG data rereferenced to linked mastoids, and the horizontal and vertical bipolar EOG 
% we can combine the three raw data structures into a single representation 
cfg = [];
data_all = ft_appenddata(cfg, data_eeg, data_eogh, data_eogv); 
figure
for ch = 1:5
    subplot(5,1,ch)  % 将图像分成5行1列，第ch个子图
    plot(data_all.time{1}, data_all.trial{1}(ch, :))
    title(['Channel: ' data_all.label{ch}])
    xlabel('Time (s)')
    ylabel('Amplitude (uV)')
end

%% Segmenting continuous data into trials 
%  S111, S121, S131, S141 correspond to the presented pictures of 4 different animals respectively. 
% The trigger codes S151, S161, S171, S181 correspond to the presented pictures of 4 different tools. 
cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr'; 
cfg.trialdef.eventtype = '?'; 
dummy = ft_definetrial(cfg) 

cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr'; 
cfg.trialdef.eventtype = 'Stimulus';
cfg.trialdef.eventvalue = {'S111', 'S121', 'S131', 'S141'};
cfg_vis_animal          = ft_definetrial(cfg);

cfg.trialdef.eventvalue = {'S151', 'S161', 'S171', 'S181'};
cfg_vis_tool            = ft_definetrial(cfg);

% The output configuration resulting from ft_definetrial contains the trial definition as a Nx3 matrix 
% the begin sample, the end sample and the offset of each trial

data_vis_animal = ft_redefinetrial(cfg_vis_animal, data_all) 
data_vis_tool = ft_redefinetrial(cfg_vis_tool, data_all) 


%% Segmenting continuous data into one_second pieces 

%read the data, and cut in one go

cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr'; 
cfg.trialfun = 'ft_trialfun_general' 
cfg.trialdef.triallength = 1;   % duration in seconds
cfg.trialdef.ntrials = inf;   % number of trials, inf results in as many as possible

cfg = ft_definetrial(cfg); 

data_segmented = ft_preprocessing(cfg) 

%% Segmenting continuous data into one_second pieces  

% read the data, and cut whatever you want 

cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\SubjectEEG\subj2.vhdr'; 
data_cont = ft_preprocessing(cfg); 


cfg = [];
cfg.length = 1; 
data_segmented = ft_redefinetrial(cfg, data_cont); 

%% 
% 可视化切好的数据段
figure
n = 5;  % 想画前5个 trial
for i = 1:n
    subplot(n, 1, i)
    plot(data_segmented.time{i}, data_segmented.trial{i}(1, :))  % 画第1个通道
    title(['Trial ' num2str(i) ' - Channel: ' data_segmented.label{1}])
    xlabel('Time (s)')
    ylabel('Amplitude (uV)')
end