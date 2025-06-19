%% Reading Data 
cfg = [] 
cfg.dataset = 'D:\MatlabCode\FieldTripdata\Subject01\Subject01.ds' 
data_meg = ft_preprocessing(cfg)  

for trialsel=1:10
    chansel = 1; 
    figure
    plot(data_meg.time{trialsel}, data_meg.trial{trialsel}(chansel, :))
    xlabel('time s') 
    ylabel('channel amplitude (a.u.)') 
    title(sprintf('trial %d', trialsel)); 
end 

%% trial definition 
cfg = [] 
cfg.dataset = 'D:\MatlabCode\FieldTripdata\Subject01\Subject01.ds'  
cfg.trialfun = 'ft_trialfun_general' 
cfg.trialdef.eventtype = 'backpanel trigger' 
% the values of the stimulus trigger for the three conditions
% 3 = fully incongruent (FIC), 5 = initially congruent (IC), 9 = fully congruent (FC)
cfg.trialdef.eventvalue = [3 5 9] 
cfg.trialdef.prestim = 1; 
cfg.trialdef.poststim = 2; 

cfg = ft_definetrial(cfg) 

%% Reading Data 
cfg.channel = {'MEG' 'EOG'}; 
cfg.continuous = 'yes'; 
data_all = ft_preprocessing(cfg); 

save PreprocData data_all

plot(data_all.time{1}, data_all.trial{1}(130, :))

%% split up the conditions by selecting trials 

cfg = [] 
cfg.trials =(data_all.trialinfo == 3); 
dataFIC = ft_selectdata(cfg, data_all); 

cfg.trials = (data_all.trialinfo == 1); 
dataIC = ft_selectdata(cfg, data_all );

cfg.trials = (data_all.trialinfo == 9); 
dataFC = ft_selectdata(cfg, data_all);


save PreprocData dataFIC dataIC dataFC -append 

%% wrtie own function 

function trl = mytrialfun(cfg); 


cfg = [];
cfg.dataset = 'D:\MatlabCode\FieldTripdata\Subject01\Subject01.ds';  
cfg.trialfun = 'ft_trialfun_general';
cfg.trialdef.eventtype = 'backpanel trigger' ;
cfg.trialdef.eventvalue = [3 5 9] 
cfg.trialdef.prestim = 1;
cfg.trialdef.pststim = 2; 

tri = []

hdr = ft_read_header(cfg.dataset); 
event = ft_read_event(cfg.dataset); 

for i = 1: length(event)
    if strcmp(event(i).type, cfg.trialdef.eventtype)
        % it is a trigger, see whether it has the right value
        if ismember(event(i).value, cfg.trialdef.eventvalue) 
            % add this to the trl definition
            begsample = event(i).sample - cfg.trialdef.prestim * hdr.Fs 
            endsample = event(i).sample + cfg.traildef.poststim * hdr.Fs 
            offest = - cfg.trialdef.prestim * fdr.Fs 
            trigger = event(i).value   % remember the trigger (=condition) for each trial
            
        if isempty(tri) 
            pretrigger = nan
        else 
            pretrigger = tri(end, 4) % the condition of the previous trial
        end
        tri = [round([begsample endsample offest]) trigger pretrigger]
        end 
    end 
end

samecondition = trl(:, 4) == trl(:, 5); 
trl(samecondition, :) = [] 

end 

%% Save the trial function together with your other scripts as mytrialfun.m. 

%cfg = [];
%cfg.dataset = 'D:\MatlabCode\FieldTripdata\Subject01\Subject01.ds';  
%cfg.trialfun = 'mytrialfun'; 
%cfg.trialdef.eventtype = 'backpanel trigger';
%cfg.trialdef.eventvalue = [3 5 9]; 
%cfg = ft_definetrial(cfg); 

%cfg.channel = {'MEG' 'STIM'} 
%dataMytrialfun = ft_prerpocessing(cfg) 


