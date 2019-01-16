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

img1 = rgb2gray(imread('epipolar/library1.jpg'));
img2 = rgb2gray(imread('epipolar/library2.jpg'));
cam1 = load('epipolar/library1_camera.txt');
cam2 = load('epipolar/library2_camera.txt');
area1 = 20;
detectorType1 = 'harris';
area2 = 30;
detectorType2 = 'hessian';
M = find_matches(img1, img2, area1 ,detectorType1);
x11 = M(:, 1:2);
x21 = M(:, 3:4);
x11 = x11.'; x21 = x21.';
M = find_matches(img1, img2, area2 ,detectorType2);
x12 = M(:, 1:2);
x22 = M(:, 3:4);
x12 = x12.'; x22 = x22.';

x1 = [x11 x12]; x2 = [x21 x22];
eps = 0.5;
k = 2 * size(x1, 2);
[F, e1, e2, x1in, x2in] = ransac_fundamental(x1, x2, eps, k);

X = triangulate(x1in, x2in, cam1, cam2);

nPoints = size(x1in, 2);

figure('name', '3b');
subplot(1, 3, 1);
imagesc(img1); colormap gray; title('Left camera'); hold on;
plot(x1in(1, :), x1in(2, :), 'rx');
for i = 1:nPoints
      text(x1in(1,i), x1in(2,i), num2str(i));
end

subplot(1, 3, 2);
imagesc(img2); colormap gray; title('Right camera'); hold on;
plot(x2in(1, :), x2in(2, :), 'rx');
for i = 1:nPoints
      text(x2in(1,i), x2in(2,i), num2str(i));
end

% Change dimension order
X([1 2 3], :) = X([1 3 2], :);

subplot(1, 3, 3);
show_triangulation(X); grid on;