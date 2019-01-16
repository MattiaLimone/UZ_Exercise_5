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
figure('name', '1b');
plot(pz, d);
xlabel('p_z [m]');
ylabel('d [m]');