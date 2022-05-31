close all;
clear all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');
[locs1, locs2] = matchPics(cv_cover, cv_desk);

rand = randperm(size(locs1, 1), 10);
random_points = locs1(rand, :);

H2to1 = computeH(locs2, locs1);
pred = H2to1*[random_points, ones(size(random_points,1),1)]';
pred = pred./pred(3,:);
pred = pred';
pred_points = pred(:,1:2);
figure;
showMatchedFeatures(cv_cover, cv_desk, random_points, pred_points, 'montage');
title('computeH');

H2to1 = computeH_norm(locs2, locs1);
pred = H2to1*[random_points, ones(size(random_points,1),1)]';
pred = pred./pred(3,:);
pred = pred';
pred_points = pred(:,1:2);
figure;
showMatchedFeatures(cv_cover, cv_desk, random_points, pred_points, 'montage');
title('computeH\_norm');

[H2to1, inliers] = computeH_ransac(locs2, locs1);
pred = H2to1*[random_points, ones(size(random_points,1),1)]';
pred = pred./pred(3,:);
pred = pred';
pred_points = pred(:,1:2);
figure;
showMatchedFeatures(cv_cover, cv_desk, random_points, pred_points, 'montage');
title('computeH\_ransac');