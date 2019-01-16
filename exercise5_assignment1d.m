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

img1 = imread('disparity/office2_left.png');
img2 = imread('disparity/office2_right.png');

img1 = imresize(img1, 0.5);
img2 = imresize(img2, 0.5);
disp = dispar(img1, img2, 2, 300);
figure('name','1d-1');
imshow(stereoAnaglyph(img1,img2));
    
figure('name', '1d - optional');
subplot(1, 3, 1);
subimage(img1); title('Left image');
subplot(1, 3, 2);
subimage(img2); title('Right image'); 
subplot(1, 3, 3);
subimage(disp,jet); title('Disparity'); 