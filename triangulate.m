function X = triangulate(pts1, pts2, P1, P2)
% Input:
% pts_1 ... 3xN left camera points in homogeneous coordinates
% pts_2 ... 3xN right camera points in homogeneous coordinates
% P_1 ... 3x4 calibration matrix of the left camera
% P_2 ... 3x4 calibration matrix of the right camera
% Output:
% X ... 4XN vector of 3D points in homogeneous coordinates
N = size(pts1, 2);
X = zeros(4, N);
for i = 1 : N
    a1 = cross_form(pts1(:,i)) ;
    a2 = cross_form(pts2(:,i)) ;
    c1 = a1*P1 ;
    c2 = a2*P2 ;
    A = [c1(1:2,:); c2(1:2,:)] ;
    % TODO: perform SVD decomposition of matrix A
    [~, ~, V] = svd(A);
    x = V(:, end) ./ V(end);
    % store the solution in vector X
    X(:, i) = x;
end
end