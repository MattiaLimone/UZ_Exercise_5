function [x1in, x2in] = get_inliers(F, x1, x2, eps)
nPoints = size(x1, 2);
if(size(x1, 1) < 3)
   x1 = [x1; ones(1, nPoints)];
   x2 = [x2; ones(1, nPoints)]; 
end

errs = zeros(1 ,nPoints);
for i = 1:nPoints
    errs(i) = reprojection_error(x1(:, i), x2(:, i), F);
end
inliers = (errs < eps);
x1in = x1(:, inliers);
x2in = x2(:, inliers);
end