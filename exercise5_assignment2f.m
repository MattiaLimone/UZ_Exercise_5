% Author: Mattia Limone
% Change the current folder to m file one
if(~isdeployed)
	cd(fileparts(which(mfilename)));
end
clc;	% Clear command window.
clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;	% Make sure the workspace panel is showing.

img1 = imread('epipolar/house1.jpg');
img2 = imread('epipolar/house2.jpg');
area = 30;
detectorType = 'hessian';
M = find_matches(img1, img2, area ,detectorType);
x1o = M(:, 1:2);
x2o = M(:, 3:4);
x1 = x1o.'; x2 = x2o.';
eps = 1;
k = 400;
[F, e1, e2, x1in, x2in] = ransac_fundamental(x1, x2, eps, k);

nInliers = size(x1in, 2);
cumErr = 0;
for i = 1:nInliers
    cumErr = cumErr + reprojection_error(x1in(:, i), x2in(:, i), F);
end
avgErr = cumErr/nInliers;
inliersRatio = nInliers/size(x1, 2);
