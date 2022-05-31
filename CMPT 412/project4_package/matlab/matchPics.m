function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if (ndims(I1) ==3)
    I1 = rgb2gray(I1);
end
if (ndims(I2) ==3)
    I2 = rgb2gray(I2);
end
%% Detect features in both images
loc1 = detectFASTFeatures(I1).Location;
loc2 = detectFASTFeatures(I2).Location;
%% Obtain descriptors for the computed feature locations
[I1_feat, I1_loc] = computeBrief(I1, loc1);
[I2_feat, I2_loc] = computeBrief(I2, loc2);
%% Match features using the descriptors
indexPairs = matchFeatures(I1_feat, I2_feat, 'MatchThreshold', 10, 'MaxRatio', 0.68);
locs1 = I1_loc(indexPairs(:, 1), :);
locs2 = I2_loc(indexPairs(:, 2), :);
end

