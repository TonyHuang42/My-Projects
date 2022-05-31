% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I1 = imread('../data/cv_cover.jpg');
if (ndims(I1) == 3)
    I1 = rgb2gray(I1);
end
%% Compute the features and descriptors
BRIEF_loc1 = detectFASTFeatures(I1).Location;
[BRIEF_I1_feat, BRIEF_I1_loc] = computeBrief(I1, BRIEF_loc1);

SURF_loc1 = detectSURFFeatures(I1).Location;
[SURF_I1_feat, SURF_I1_loc] = extractFeatures(I1, SURF_loc1, 'Method', 'SURF');

BRIEF_list = zeros(35, 1);
SURF_list = zeros(35, 1);

for i = 0:36
    %% Rotate image
    I2 = imrotate(I1, i*10);
    %% Compute features and descriptors
    BRIEF_loc2 = detectFASTFeatures(I2).Location;
    [BRIEF_I2_feat, BRIEF_I2_loc] = computeBrief(I2, BRIEF_loc2);
    
    SURF_loc2 = detectSURFFeatures(I2).Location;
    [SURF_I2_feat, SURF_I2_loc] = extractFeatures(I2, SURF_loc2, 'Method', 'SURF');
    %% Match features
    BRIEF_indexPairs = matchFeatures(BRIEF_I1_feat, BRIEF_I2_feat, 'MatchThreshold', 10.0, 'MaxRatio', 0.68);
    SURF_indexPairs = matchFeatures(SURF_I1_feat, SURF_I2_feat, 'MatchThreshold', 100, 'MaxRatio', 0.68);
    %% Update histogram
    BRIEF_list(i+1, 1) = size(BRIEF_indexPairs, 1);
    SURF_list(i+1, 1) = size(SURF_indexPairs, 1);
    %% Visualize
    if (i == 3 || i == 10 || i == 20)
        figure;
        showMatchedFeatures(I1, I2, BRIEF_I1_loc(BRIEF_indexPairs(:, 1), :), BRIEF_I2_loc(BRIEF_indexPairs(:, 2), :), 'montage');
        figure;
        showMatchedFeatures(I1, I2, SURF_I1_loc(SURF_indexPairs(:, 1), :), SURF_I2_loc(SURF_indexPairs(:, 2), :), 'montage');
    end
end
%% Display histogram
figure;
bar(linspace(0,360,37), BRIEF_list);
title('BREIF')

figure;
bar(linspace(0,360,37), SURF_list);
title('SURF')