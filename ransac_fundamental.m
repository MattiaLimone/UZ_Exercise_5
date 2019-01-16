function [F, e1, e2, x1, x2] = ransac_fundamental(x1, x2, eps, k)
% Input:
% x1, x2 : 3xN matrix of N homogeneous points v 2D space
% eps : threshold for inliers
% k : number of iterations
% Output:
% F : 3x3 fundamental matrix: x2' * F * x1 = 0
% e1 : Epipol in image 1: F * e1 = 0
% e2 : Epipol in image 2: F' * e2 = 0
% x1, x2 : 3xNi matrix of Ni homogeneous inlier points
N = size(x1, 2);

bestVotes = 0;
bestF = zeros(3, 3);
x1inBest = 0;
x2inBest = 0;

for i = 1:k
    % Randomly select 8 points
    ind = randperm(N, 8);
    x1rand = x1(:, ind); x2rand = x2(:, ind);
    
    % Find homography from those 4 points
    F = fundamental_matrix(x1rand, x2rand);
    
    % Count votes
    [x1in, x2in] = get_inliers(F, x1, x2, eps);
    votes = size(x1in, 2); % Count only those points near enough
    
    % Estimate model from inliers, store best model
    if votes > bestVotes && votes > 7
        %bestF = F;
        bestF = fundamental_matrix(x1in, x2in);
        [x1in, x2in] = get_inliers(bestF, x1in, x2in, eps);
        x1inBest = x1in;
        x2inBest = x2in;
        bestVotes = votes;
    end
end
F = bestF;

[U, ~, V] = svd(F);
e1 = V(:, end)./V(end);
e2 = U(:, end)./U(end);

x1 = x1inBest;
x2 = x2inBest;
end