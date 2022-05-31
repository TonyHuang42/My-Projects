function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
n = size(pts1, 1);
im1 = double(im1);
im2 = double(im2);
W = size(im1, 2);
pts2 = zeros(n,2);
window = 10;

for i = 1:n
    x = round(pts1(i,1));
    y = round(pts1(i,2));
    crop1 = im1(y-window:y+window, x-window:x+window,:);
    line = F * [x,y,1]';
    min = Inf;
    point = zeros(1,  2);

    for x = 1+window:W-window
        y = round((-line(3) - line(1)*x)/line(2));
        crop2 = im2(y-window:y+window, x-window:x+window,:);
        distance = sqrt(sum((crop1(:) - crop2(:)) .^ 2));
        if distance < min
            min = distance;
            point = [x, y];
        end
    end
    pts2(i, :) = point;
end
end
