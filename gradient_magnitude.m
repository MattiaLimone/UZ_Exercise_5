function [Imag, Idir] = gradient_magnitude(img, sigma)
[Ix, Iy] = image_derivatives(img, sigma);
Ix = double(Ix); Iy = double(Iy);
Imag = sqrt(Ix.^2 + Iy.^2);
Idir = atan2(Iy, Ix);
end