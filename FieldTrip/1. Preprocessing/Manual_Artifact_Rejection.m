%% Reading Data 
load PreprocData data_all  

%% Browse through the data trial by trial 

cfg = []; 
cfg.method = 'trial'; 
cfg.ylim= [-1e-12 1e-12]; 
cfg.megscale = 1; 
cfg.eogscale = 5e-8;
cfg.emgscale  = 5e-8;
cfg.ecgscale  = 5e-8;
dummy = ft_rejectvisual(cfg, data_all);

%% Display one channel at a time 

cfg = []; 
cfg.method = 'channel'; 
cfg.ylim = [-1e-12 1e-12]; 
cfg.megscale = 1; 
cfg.ecgscale = 5e-8; 
cfg.eogscale = 5e-8; 
cfg.emgsscale = 5e-8; 
dummy = ft_rejectvisual(cfg, data_all); 

%% Display a summary 

cfg =[]; 
cfg.method = 'summary'; 
cfg.ylim = [-1e-12 1e-12]; 
cfg.megscale = 1;
cfg.eogscale = 5e-8; 
cfg.ecgscale = 5e-8; 
cfg.megscale = 5e-8; 
dummy = ft_rejectvisual(cfg, data_all);

%% 
%cfg = []; 
%cfg.method = 'summary'; 
%cfg.keepchannel = 'yes'

%cfg.channel = 'MEGMAG'; 
%clean1 = ft_rejectvisual(cfg, data_all); 

%cfg.channel = 'MEGGRAD'; 
%clean2 = ft_rejectvisual(cfg, clean1); 

%cfg.channel = 'EEG'; 
%clean3 = ft_rejectvisual(cfg, clean2); 

%% 
%cfg = []; 
%cfg.channel = 'MEGMAG';
%dummy1 = ft_selectdata(cfg, orig); 
%cfg.channel = 'MEGGRAD'; 
%dummy2 = ft_selectdata(cfg, orig); 
%cfg.channel = 'EEG'; 
%dummy3 = ft_selectdata(cfg, orig); 

%cfg = []; 
%cfg.method = 'summary'; 
%cfg.leepchannel = 'no'; 
%cfg.keeptrials = 'no'; 

%dummy1 = ft_rejectvisual(cfg, dummy1); 
%dummy2 = ft_rejectvisual(cfg, dummy2); 
%dummy3 = ft_rejectvisual(cfg, dummy3); 

%cfg = []; 
%cfg.channel = union(dummy1.cf.channel, dummy2.cfg.channel, dummy3.cfg.chaennle); 
%cfg.trials = intersect(dummy1.cfg.trials, dummy2.cfg.trials, dummy3.cfg.trials); 
%clean = ft_selectdata(cfg, orig)