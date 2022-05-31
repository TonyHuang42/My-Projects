%% Reading and displaying 1D temporal data
% Here we show examples of data taken from single dimension of
% *time*. Each time point can have a _single_ number, or _multiple_ numbers
% associated with it.

%% How to run this demo
% You can download the datasets from Canvas

%%
% Download the below files and re-create the directory structure given below.
%   
%   /display_1d.m 
%   /ecg/ecgdemodata1.mat
%   /eeg/130-2_c4.asc.txt
%   /eeg/Z001.txt
%   /eeg/Z002.txt
%   /eeg/Z003.txt


% First, let's close any windows we have open.
close all

% And get rid of any variables in memory.
clear variables

%% Example of 1D, single channel ECG data 
% We examine ECG data here, which measures the electrical activity of the heart
% over time, using electrodes that are attached to the patients skin. 

% This is the path and name of the ECG file.
ecgNamePath = fullfile(pwd, 'ecg', 'ecgdemodata1.mat');

% Load the MAT file containing the ECG values.
ecgStruct = load(ecgNamePath);
ecg = ecgStruct.ecg;

% We have 44604 time points with a single value.
size(ecg)
%%

% This is the values of the first 5 points.
ecg(1:5)
%%

% Create a value for each time point.
xDim = 1:size(ecg,2);

% Create an empty figure for display. 
figure; 
% Plot time vs. eeg value.
plot(xDim,ecg); 
title('time vs. ecg value');

% Label the axis.
xlabel('time');
ylabel('ecg-value');
%%

% We are looking at all the data here. What happens when we only look at
% the first few points? Here we start by looking at the first 1/2 points,
% then we look at the first 1/4 points, etc... 

% Let's just take a look at the first 500 values.
for a=0:10
    % Reduce by this much.
    reduceBy = 2^a;    
    
    % Number_of_points_in_the_ecg / factor_to_reduce_by
    maxTime = round(size(ecg,2) / reduceBy);    
    xDim = 1:maxTime;
    
    figure; 
    plot(xDim, ecg(1:maxTime),'.');
    title(sprintf('Looking at the first 1/%i points',reduceBy));
    xlabel('time');
    ylabel('ecg-value');
    
    pause(0.5)
    % snapnow() is for publishing to the web (you can ignore it).
    snapnow;
end
%%

%% Example of 1D, single channel EEG data 
% Here we have a subject who had a single electrode connected to their
% scalp. The subject was recorded for 3 minutes with pre-seizure, seizure, and
% post-seizure activity captured. The data is simp  ly stored in a textfile
% where each line stores a value.

eegSingleNamePath = fullfile(pwd, 'eeg','130-2_c4.asc.txt');

% Read in the text data. 
eegSingle = importdata(eegSingleNamePath);

% We have 18432 time points with a single value.
size(eegSingle)
%%

% Let's look at the first 5 values. These are the measures of electrical
% actvities for the first 5 points in time.
eegSingle(1:5)
%%

% How many points in time the electrical activity was measured.
xDim = 1:size(eegSingle,1);


figure;
% Plot time vs. eeg value.
plot(xDim,eegSingle); 
title('time vs. eeg value');

% Label the axis.
xlabel('time');
ylabel('eeg-value');



%% Example of 1D, multi-channel data
% For a particular point in time, a data point can have several values
% associated with it. So now we look at multi-channel data with 3 data
% values that correspond to one time point.
%
% The original data can be downloaded from this site,
% http://epileptologie-bonn.de/cms/front_content.php?idcat=193&lang=3&changelang=3
%
% Based on this publication:
%
% Andrzejak RG, Lehnertz K, Rieke C, Mormann F, David P, Elger CE (2001) 
% Indications of nonlinear deterministic and finite dimensional structures in time series of brain electrical activity: Dependence on recording region and brain state, 
% Phys. Rev. E, 64, 061907,
% 
% There are a 100 single-channel EEG segments of 23.6 seconds were captured for
% a single patient. Let's just look at only 3 channels.

ch1 = fullfile(pwd, 'eeg', 'Z001.txt');
ch2 = fullfile(pwd, 'eeg', 'Z002.txt');
ch3 = fullfile(pwd, 'eeg', 'Z003.txt');

% We create a matrix where the rows are the time samples and the columns
% are different channels.
eegMulti(:,1) = importdata(ch1);
eegMulti(:,2) = importdata(ch2);
eegMulti(:,3) = importdata(ch3);

% number of samples x number of channels
size(eegMulti)
%%

% We can look at just a few samples here.
eegMulti(1:5,:)
%%

% Let's look at all the time points.
xDim = 1:size(eegMulti,1);

figure;
% "hold on" allows us to use the multiple plots.
hold on;

% Plot the values from separate channels on the same figure.
plot(xDim, eegMulti(xDim,1),'r');
plot(xDim, eegMulti(xDim,2),'g');
plot(xDim, eegMulti(xDim,3),'b');
title('time vs. eeg value'); xlabel('time'); ylabel('eeg-value');
%%

% Hard to see what's going on. Let's just look at the first 100 time
% points.
xDim = 1:100;%size(eegMulti,1);

figure;
hold on;
plot(xDim, eegMulti(xDim,1),'r.-');
plot(xDim, eegMulti(xDim,2),'g.-');
plot(xDim, eegMulti(xDim,3),'b.-');
title('time vs. eeg value'); xlabel('time'); ylabel('eeg-value');
