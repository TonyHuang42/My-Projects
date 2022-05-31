% A test script using templeCoords.mat
%
% Write your code here
%
clear;
close all;

load '../data/someCorresp.mat'
F = eightpoint(pts1, pts2, M);
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
%displayEpipolarF(im1, im2, F);
%epipolarMatchGUI(im1, im2, F);

load('../data/templeCoords.mat');
pts2 = epipolarCorrespondence(im1, im2, F, pts1);

load('../data/intrinsics.mat');
E = essentialMatrix(F,K1,K2);
P1 = K1 * [eye(3),zeros(3,1)];
candidates = camera2(E);
count = zeros(1,4);
for i = 1:4
    P2 = K2 * candidates(:,:,i);
    pts3d = triangulate(P1, pts1, P2, pts2);
    count(i) = sum(pts3d(:, 3) > 0);
end

index = find(count==max(count),1);
extrinsics = candidates(:,:,index);
P2 = K2 * extrinsics;

proj1 = P1 * [pts3d ones(size(pts1,1),1)]';
proj1 = proj1(1:2, :)./proj1(3,:);
dist1 = (pts1' - proj1).^2;
error1 = sum(sqrt(dist1(1,:)+dist1(2,:))) / size(pts1,1);
disp('erroe1');
disp(error1);

proj2 = P2 * [pts3d ones(size(pts1,1),1)]';
proj2 = proj2(1:2, :)./proj2(3,:);
dist2 = (pts2' - proj2).^2;
error2 = sum(sqrt(dist2(1,:)+dist2(2,:))) / size(pts2,1);
disp('error2');
disp(error2);

pts3d = triangulate(P1, pts1, P2, pts2);

plot3(pts3d(:,1),pts3d(:,2),pts3d(:,3),'b.');
axis equal;

R1 = eye(3);
t1 = zeros(3,1);
R2 = extrinsics(:,1:3);
t2 = extrinsics(:,4);
% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');