function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points
height = size(x1, 1);
A = zeros(2*height, 9);

for i = 1: height
        A(i*2-1,:) = [-x2(i,1), -x2(i,2), -1, 0,0,0, x2(i,1)*x1(i,1), x2(i,2)*x1(i,1), x1(i,1)];
        A(i*2,:)  =  [0,0,0, -x2(i,1), -x2(i,2), -1, x2(i,1)*x1(i,2), x2(i,2)*x1(i,2), x1(i,2)];
end
[~,~,V] = svd(A);
H2to1 = reshape(V(:,9),[3,3])';
end
