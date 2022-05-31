function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

%Q2.2.3

bestH2to1 = 0;
inliers = -1;
max = -1;
for i=1:1000
    rand = randperm(size(locs1, 1), 4);
    rand1 = locs1(rand, :);
    rand2 = locs2(rand, :);
    
    H2to1 = computeH_norm(rand1, rand2);
    pred = H2to1*[locs2, ones(size(locs2,1),1)]';
    pred = pred./pred(3,:);
    pred = pred';
    
    dist = sqrt((locs1(:,1)-pred(:,1)).^2 + (locs1(:,2)-pred(:,2)).^2);
    dist = dist<1;
    if(sum(dist)>max)
        max = sum(dist);
        bestH2to1 = H2to1;
        inliers = dist;
    end
end
