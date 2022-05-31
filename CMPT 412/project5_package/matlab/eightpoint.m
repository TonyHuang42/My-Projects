function F = eightpoint(pts1, pts2, M)
%load '../data/someCorresp.mat'
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

M = [1/M,0,0;
         0,1/M,0;
         0,0,1];

norm1 = M * [pts1,ones(size(pts1,1),1)]';
norm2 = M * [pts2,ones(size(pts1,1),1)]';

A = [norm2'.*norm1(1,:)', norm2'.*norm1(2,:)', norm2'];

[~, ~, V] = svd(A);
F = reshape(V(:,9),3,3);
[U,S,V] = svd(F);
S(3,3) = 0;
F = U*S*V';
refine_F = refineF(F,norm1(1:2,:)',norm2(1:2,:)');
F = (M'*refine_F*M);

