function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

A = P(:,1:3);
P = sign(det(A)) * P;
[~, ~, V] = svd(P);

c = V(:, end);
c = c(1:3) ./ c(4);

p = [0 0 1;0 1 0;1 0 0];

A_reverse = p * A;
[r, q] = qr(A_reverse');
K = p * q' * p;
R = p * r' ;

x = diag(sign(diag(K)));
K = K * x;
R = x * R;
K = K / K(3, 3);
if det(R) < 0
    R = -R;
end
t = -R*c;
end