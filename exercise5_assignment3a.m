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
cam1 = load('epipolar/house1_camera.txt');
cam2 = load('epipolar/house2_camera.txt');
corresp = load('epipolar/house_points.txt');
x1o = corresp(:, 1:2);
x2o = corresp(:, 3:4);
x1 = x1o.'; x2 = x2o.';
nPoints = size(x1, 2);
x1 = [x1; ones(1, nPoints)];
x2 = [x2; ones(1, nPoints)];

X = triangulate(x1, x2, cam1, cam2);

figure('name', '3a');
subplot(1, 3, 1);
imagesc(img1); title('Left camera'); hold on;
plot(x1(1, :), x1(2, :), 'rx');
for i = 1:nPoints
      text(x1(1,i), x1(2,i), num2str(i));
end

subplot(1, 3, 2);
imagesc(img2); title('Right camera'); hold on;
plot(x2(1, :), x2(2, :), 'rx');
for i = 1:nPoints
      text(x2(1,i), x2(2,i), num2str(i));
end

% Change dimension order
X([1 2 3], :) = X([1 2 3], :);

subplot(1, 3, 3);
show_triangulation(X); grid on;