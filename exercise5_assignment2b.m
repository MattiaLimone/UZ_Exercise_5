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
x1 = corresp(:, 1:2);
x2 = corresp(:, 3:4);
[F, ~, ~] = fundamental_matrix(x1.', x2.')

x1 = x1.'; 
x2 = x2.';
nPoints = size(x1, 2);
x1 = [x1; ones(1, nPoints)];
x2 = [x2; ones(1, nPoints)];

p = [85 233 1];
line1 = F * p.';

figure('name', '2b');
subplot(1, 2, 1);
imagesc(img1); colormap gray; title('Left image');
hold on;
plot(x1(1, :), x1(2, :), 'rO');
plot(p(1), p(2), 'gX');


subplot(1, 2, 2);
imagesc(img2); colormap gray; title('Right image');
hold on;
plot(x2(1, :), x2(2, :), 'rO');
draw_line(line1, size(img1, 2), size(img1, 1), 'g');