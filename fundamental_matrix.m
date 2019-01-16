function [F, e1, e2] = fundamental_matrix(x1, x2)
% Input: x1, x2 : 3xN N homogeneous points in 2D
% Output:
% F : 3x3 fundamental matrix: x2' * F * x1 = 0
% e1 : epipol in the first image: F * e1 = 0
% e2 : epipol in the second image: F' * e2 = 0
nPoints = size(x1, 2);
if nPoints < 8
   error('Error - need at least 8 points to compute fundamental matrix'); 
end

[x1, T1] = normalize_points(x1);
[x2, T2] = normalize_points(x2);

A = zeros(nPoints, 9);
for i = 1:nPoints
    u = x1(1, i); v = x1(2, i);
    ud = x2(1, i); vd = x2(2, i);
    A(i, :) = [u*ud u*vd u v*ud v*vd v ud vd 1];
end
[~, ~, V] = svd(A);
f = V(:, end) ./ V(end);

Ft = reshape(f, 3, []);

[U, D, V] = svd(Ft);
D(end) = 0; % Fix to ensure rank 2
Ftran = U * D * V';

F = T2.' * Ftran * T1; % Transform back
[U, ~, V] = svd(F);

e1 = V(:, end)./V(end);
e2 = U(:, end)./U(end);
end