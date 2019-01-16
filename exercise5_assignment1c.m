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

f = 2.5e-3; % 2.5mm
T = 12e-2; % 12cm
pz = 0.2:0.2:20;
px = ones(size(pz));
d = f .* (T) ./ pz;

pw = 7.4e-6; % pixel width
d1 = f*T / ((550 - 300) * pw);
d2 = f*T / ((550 - 540) * pw);    