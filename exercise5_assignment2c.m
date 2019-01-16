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

corresp = load('epipolar/house_points.txt');
x1 = corresp(:, 1:2);
x2 = corresp(:, 3:4);
x1 = x1.'; x2 = x2.';
[F, ~, ~] = fundamental_matrix(x1, x2);
nPoints = size(x1, 2);
x1 = [x1; ones(1, nPoints)];
x2 = [x2; ones(1, nPoints)];

p1 = [85 233 1].';
p2 = [67 219 1].';
avgErr1 = reprojection_error(p1, p2, F);

cumErr2 = 0;
for i = 1:nPoints
    cumErr2 = cumErr2 + reprojection_error(x1(:, i), x2(:, i), F);
end
avgErr2 = cumErr2/nPoints