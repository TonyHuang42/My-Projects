function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

n = size(x, 2);
x1 = x(1,:)';
x2 = x(2,:)';

A1 = [-X', -ones(n,1), zeros(n,4), x1.*X', x1];
A2 = [zeros(n,4), -X', -ones(n,1), x2.*X', x2];
A = [A1; A2];

[~, ~, V] = svd(A);
P = reshape(V(:, end), 4, 3)';
end