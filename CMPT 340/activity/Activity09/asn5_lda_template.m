%% Classification using Linear Discriminate Analysis (LDA)
% CMPT 340 - Activity 09
%
% In this assignment, we are going to examine data from patients with
% Multiple Sclerosis (MS). Specifically, we are going to try to distinguish
% between patients with advanced stages of MS vs earlier stages of MS. We
% are going to make this distinction (classification) using ONLY
% information from the patients' spinal cord in an MRI.
%
%
% *Data files:*
% We have extracted some features from 30 patients with different stages of
% MS. The features are measurements of the spinal cord in an MRI. For
% example, the volume of the spinal cord, the average intensity within the
% cord, etc. The corresponding severity of MS for each patient is also
% included. 
%
% The data is in the file "SC.mat" and how to load the data is given below.
%
% *Instructions:*
% Detailed instructions are below. Please read the instructions carefully
% and follow along, filling out the requested areas. 
%
%
% *Marking:*
% Please note the TA marks based on the HTML and the code so please keep
% both readable. Marks may be deducted for poorly formatted works.
%
% The marks for each question are given in the [] brackets.
% e.g. [3] is three marks.
% 
% *Total Marks:*
% Out of 10


% Clean-up
clear; close all; clc

%% Load the MS dataset.
SC = load('data\SC');
SC = SC.SC;

% Let's look at the original data.
targets = SC.target;
figure(1)
plot(targets,'.');
xlabel('observations (patients)'); ylabel('MS severity (lower is more severe)');
size(targets)
title('Visualization of the original data')
%%

% Convert to our binary class data of "early" vs "advanced" stage of MS.
C = zeros(size(targets,1),1);

% A cut-off of 0.3 is arbitrarily chosen so we have equal number of early
% and advanced patients.
C(targets<0.3) = 1;

% Examine the binary data. This is what we will try to predict. We will try
% to predict if a patient should be 0 (early) or advanced (1).
figure(2)
plot(C,'.')
axis([0,30,-1,2]); xlabel('observations (patients)'); ylabel('severity (0 is early, 1 is advanced)');
title('Examine the binary data')
%%

% Now we make an observation matrix with all our features and the class
% label at the end.
obs = [...
    SC.mCordPx_mn, SC.mCordPx_std, SC.mDistMax, SC.mDistMn, ...
    SC.mDistMnMax, SC.mEcc, SC.mMajAx, SC.mMinAx, ...
    SC.mPerMax, SC.mPerMn, SC.mPerStd, SC.mPerMin, ... % based on the the perimeter of the cord.
    SC.volume./20, ... % volume of the cord. We divide the volume by 20 since the other features were averaged over 20 slices.
    C % the class label.
    ];

% Our observation matrix consists of:
% 30 rows (observations or patients),
% with 13 features for each patient,
% and the class label (14 columns).
size(obs)


%% Q1. Create two matrices for early and advanced patients [1]
% Create two separate observation matrices where one contains only the
% patients with the "early" (0) class labels, and the other contains
% patients with only the "advanced" (1) class labels.
%
% All the features should be included in the matrix. But the class label
% should NOT be included.
%
% Note that you need to order your features properly to pass the test

%-------- Your work here -----
clear obsEarly obsAd

a = 0;
b = 0;
for i = 1:30
    if C(i, 1) == 0
        a = a+1;
        obsEarly(a, :) = obs(i, :);
    end
    if C(i, 1) == 1
        b = b + 1;
        obsAd(b, :) = obs(i, :);
    end 
end
obsEarly(:, 14) = [];
obsAd(:, 14) = [];

clear a b i


%--- check --------------------
display(sprintf('obsEarly size: %i', isequal(size(obsEarly), [15,13])))
display(sprintf('obsAd size: %i', isequal(size(obsAd), [15,13])))
display(sprintf('obsEarly vals: %i', isequal(round(obsEarly(2,3:8)*1000), [  2983        1519         509         864        5508        2746])))
display(sprintf('obsAd vals: %i', isequal(round(obsAd(5,8:end)*1000), [  2818        5734        3840         938        2318       55724])))
%------------------------------

%% Q2. Explore separating the data based on 1 feature (1D) [0.5]
% Let's use the last feature, which should correspond to the "volume"
% features. This is the volume of the patients' spinal cord.
% 
% On a single figure, plot the "volume" feature from the "early"
% observation matrix in blue, and the "volume" feature from the "advanced"
% matrix in red. 
%
% Note how much the two classes overlap and we cannot distinguish "early" from
% "advanced" from a single feature alone.
%
% Also, show how much the two histograms overlap

figure(3);
%----- Your work here ----
plot (obsEarly(:, 13), 'b.')
hold on
plot(obsAd(:, 13), 'r.')
hold off
%--------------------------
figure(4)
%----- Your work here ----
histogram(obsEarly(:, 13), [30:10:100])
hold on

histogram(obsAd(:, 13), [30:10:100])

hold off


%--------------------------
% This motivates our need to look at multiple features and histogram when trying to
% distinguish/classify between "early" and "advanced" stages of MS.


%% Q3. Compute the mean features observation matrices [0.5]
% Compute the mean features (_meanEarly_, _meanAd_) for the early and advanced observation
% matrices.

%----- Your work here -----
for i = 1:13
    meanEarly(1, i) = mean(obsEarly(:, i));
    meanAd(1, i) = mean(obsAd(:, i));
end
clear i

%----- check -----
display(sprintf('size meanEarly:%i',isequal(size(meanEarly),[  1    13])));
display(['meanAd vals:', num2str(round(meanAd(2:7)*1000))]);

%-----------------


%% Q4. Compute the covariance matrices for each observation matrix [0.5]
% Compute two covariance matrices (_covEarly_, _covAd_) for the early and 
% advanced observations.

%----- Your work here -----
covEarly = cov(obsEarly);
covAd = cov(obsAd);
%----- check -----
display(['covEarly vals:', num2str(round(covEarly(1:5)*10000))]);
display(sprintf('size covAd:%i',isequal(size(covAd),[  13    13])));
%-----------------


%% Q5. Compute the vector (V) that maximally separates the data [1]
%
% hint: see the equation to compute "v" on the lecture slides

%----- your work here -----
V = (inv(covEarly + covAd)) * ((meanEarly - meanAd)');

%----- check -----
display(sprintf('size V:%i',isequal(size(V),[  13    1])));
display(['V vals:',num2str(round(V(2:7)*1000)')]);
%-----------------


%% Q6. Project observation matrices onto 1D using V [1]
% Using the computed v, project each observation matrix onto a 1D line.
% Call them _obsEarly_1D_ and _obsAd_1D_
%

%----- Your work here -----
obsEarly_1D = obsEarly * V;
obsAd_1D = obsAd * V;

%----- check -----
display(sprintf('size obsEarly_1D:%i',isequal( size(obsEarly_1D),[  15    1])));
display(['obsAd_1D vals:', num2str(round(obsAd_1D(7:12)*1000)')]);
%-----------------


%% Q7. Fit a Gaussian distribution to the 1D projection [1]
% To fit a Gaussian, we first estimate the mean and standard deviation of
% the 1D early and advanced projections. Use the variable names below.

%----- Your work here -----
meanEarly1d = mean(obsEarly_1D);
meanAd1d = mean(obsAd_1D);

stdEarly1d = std(obsEarly_1D);
stdAd1d = std(obsAd_1D);

%----- check -----
display(['mEarly1d vals:',num2str(round(meanEarly1d*10000))]);
display(['sAd1d vals:', num2str(round(stdAd1d*10000))]);
%-----------------


% Create some variables to plot the Gaussian. 
% This could go from -inf to +inf, but for clarity we only show -8 to +5.
x = -8:0.01:5;

figure(5)
% We use the normal distribution.
earlyY = 1/(stdEarly1d* sqrt(2*pi)) * exp(- (((x-meanEarly1d).^2)./(2*stdEarly1d^2)));
h1 = plot(x,earlyY,'.b');

%% Q8. Fit a Gaussian distribution for the advanced observations [1]
% Examine the above equation for the normal distrubtion used to compute
% _earlyY_. In a similar fashion, plot the normal distrubtion for the 
% advanced observations using the mean and std dev computed for 
% the 1D advanced projection earlier.

figure(5)
%----- your work here -----
adY = 1/(stdAd1d* sqrt(2*pi)) * exp(- (((x-meanAd1d).^2)./(2*stdAd1d^2)));
h1 = plot(x,adY,'.b');
%--------------------------

%% Decide on set of thresholds to make the ROC curve.
% We want to get a bunch of thresholds to sample the data from.
% We have already seen this type of practices from Activity 08

if meanEarly1d <= meanAd1d
    T= linspace(meanEarly1d-5,meanAd1d+5,1000);
else
    T= linspace(meanAd1d-5,meanEarly1d+5,1000);
end


%% Q9. Reveiver Operating Characteristics [1]
% Compute the True Negative (TN) and False Negative (FN) values for the ROC curve.
% Compute values for each threshold (T) value.
% i.e. for every element in T, we calculate an element in TN and an element
% in FN.
%
% To compute the TN and FN, we will assume that the Gaussain that we computed
% earlier models the distribution.
%
% We want to find the area under the Gaussian distrubution up until the
% threshold point.
% 
% Your result should be two vectors, each the same length as T.
%
% Hint 1: We can compute this area using the function:
% _normcdf()_
%
% Hint 2: FN = 1-TP
%----- Your work here -----
TN = normcdf(T, meanAd1d, stdAd1d);
FN = normcdf(T, meanEarly1d, stdEarly1d);
%----- check ----
display(sprintf('size TN:%i', isequal(size(TN), size(T))));
%----------------

%% Q10. Plot the ROC curve [1]
% Plot the ROC curve and give appropriate labels to the axes. Follow the
% example shown in the slides.

figure(6)
%----- Your work here -----
plot(FN, TN, '.')

%% Q11. Choose a threshold [1]
% Based on the ROC curve, we can choose a threshold. 
% Choose this threshold based on where we get the highest sum of 
% "True Negative plus True Positive" 
%
% Note that "True Positive" is (1-FN).
%
% Get the index (_threshIdx_) into T that corresponds to this threshold.

%----- Your work here -----
 [~, threshIdx] = max(TN + 1 - FN);
%----- check ----
display(sprintf('theshIdx:%i', round(T(threshIdx)*10000)));
%----------------


%% Visualize the threshold.
figure(6)
hold on; % Note we are adding to the figure you created above.
plot(FN(threshIdx), TN(threshIdx),'*r','MarkerSize',20);
title('Visualization of ROC curve and chosen threshold')
% Thus T(threshIdx) is our threshold we want to use to separate our 1D data.

% This is what T(threshIdx) looks like on the 1D plot.
figure(7)
h61 = plot(x,earlyY,'.b');
hold on;
h62 = plot(x, adY,'.r');
h63 = plot(T(threshIdx),(0:0.001:0.5),'.k');
legend([h61, h62, h63(1)], 'early', 'advanced', 'chosen threshold')
title('Show the threshold on the Gaussian distributions')

%% Q12. Classify the 1D projected data [0.5]
% Now that we have chosen our threshold (T(threshIdx)) to separate early from advanced
% patients, we can go back our 1D data. Use the 1D early and advanced
% observation matrices to hold on;classify if the patient is in the early or
% advanced stages of MS. Use our computed threshold to decide if the
% patient is "early" or "advanced".
%
% How many do we correctly classify as "early"?
%
% How many do we correctly classify as "advanced"?

%----- Your work here -----
correctEarly = sum(obsEarly_1D(:) >= T(threshIdx));
correctAdvanced = sum(obsAd_1D(:) <= T(threshIdx));
%----- output ----
display(sprintf('Correct early:%i/15', correctEarly));
display(sprintf('Correct advanced:%i/15', correctAdvanced));
%-----------------

