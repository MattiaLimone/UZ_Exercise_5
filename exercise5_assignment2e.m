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
corresp = load('epipolar/house_matches.txt');
x1o = corresp(:, 1:2);
x2o = corresp(:, 3:4);
x1 = x1o.'; x2 = x2o.';
eps = 0.2;
k = 200;
[F, ~, ~, x1in, x2in] = ransac_fundamental(x1, x2, eps, k);

nInliers = size(x1in, 2);
cumErr = 0;
for i = 1:nInliers
    cumErr = cumErr + reprojection_error(x1in(:, i), x2in(:, i), F);
end
avgErr = cumErr/nInliers;
inliersRatio = nInliers/size(x1, 2);

chosenPoint = randi(nInliers, 1);
p2 = x2in(:, chosenPoint);
p1 = x1in(:, chosenPoint);
line1 = F * p1;

figure('name', '2e');
subplot(1, 2, 1);
imagesc(img1); colormap gray; title('Left image, outliers (blue), inliers (red), selected (green)');
hold on;
plot(x1(1, :), x1(2, :), 'bo');
plot(x1in(1, :), x1in(2, :), 'ro');
plot(p1(1), p1(2), 'go');

subplot(1, 2, 2);
imagesc(img2); colormap gray; title(strcat(['Inliers:', num2str(100*inliersRatio, 2), '%, error: ', num2str(avgErr, 3)]));
hold on;
plot(x2(1, :), x2(2, :), 'bo');
plot(x2in(1, :), x2in(2, :), 'ro');
plot(p2(1), p2(2), 'go');
draw_line(line1, size(img1, 2), size(img1, 1), 'g');