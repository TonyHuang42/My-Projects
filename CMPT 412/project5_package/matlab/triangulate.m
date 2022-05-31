function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
n = size(pts1,1);
X = zeros(n, 3);
    for i = 1:size(pts1,1)
        A = [pts1(i,2)* P1(3,:) - P1(2,:);
                P1(1,:) - pts1(i,1)*P1(3,:);
                pts2(i,2)*P2(3,:) - P2(2,:);
                P2(1,:) - pts2(i,1)*P2(3,:)];
        
        [~,~,V] = svd(A);
        temp = V(:, end)';
        X(i,:) = temp(1:3)/temp(4);
    end
pts3d = X;
end