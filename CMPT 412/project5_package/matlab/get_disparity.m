function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

dispM = zeros(size(im1));
w = ((windowSize-1)/2);
for y = w+1:size(im1,1)-w
    for x = w+maxDisp+1:size(im1,2)-w
        window1 = im1(y-w:y+w,x-w:x+w);
        dist = zeros(maxDisp+1, 1);
        for d = 0:maxDisp
            window2 = im2(y-w:y+w,x-d-w:x-d+w);
            dist(d+1, 1) = sum((window1-window2).^2,'all');
        end
        dispM(y,x) = find(dist==min(dist), 1)-1;
    end
end