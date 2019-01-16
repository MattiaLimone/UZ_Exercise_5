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
corresp = load('epipolar/house_points.txt');
x1o = corresp(:, 1:2);
x2o = corresp(:, 3:4);
x1 = x1o.'; x2 = x2o.';
[F, ~, ~] = fundamental_matrix(x1, x2);
[x1in, x2in] = get_inliers(F, x1, x2, 0.4);

figure('name', '2d');
subplot(1, 2, 1);
imagesc(img1); colormap gray; title('Left image');
hold on;
plot(x1(1, :), x1(2, :), 'rx');
plot(x1in(1, :), x1in(2, :), 'gx');


subplot(1, 2, 2);
imagesc(img2); colormap gray; title('Right image');
hold on;
plot(x2(1, :), x2(2, :), 'rx');
plot(x2in(1, :), x2in(2, :), 'gx');