function [Ixx, Iyy, Ixy] = image_derivatives2(img, sigma)
[Ix, Iy] = image_derivatives(img, sigma); % Get first derivatives
[Ixx, Ixy] = image_derivatives(Ix, sigma);
[~, Iyy] = image_derivatives(Iy, sigma);
end