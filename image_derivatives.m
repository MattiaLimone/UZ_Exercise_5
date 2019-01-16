function [Ix, Iy] = image_derivatives(img, sigma)
% img is grayscale image
g = gauss(sigma);
dg = gaussdx(sigma);

mtd = 'same';
p = round(3*sigma);
B = padarray(img,[p p],'replicate','both');
Ix = conv2(conv2(B, g.', mtd), dg, mtd); % First derivative is convolution with derived gaussian
Iy = conv2(conv2(B, g, mtd), dg.', mtd);

Ix = Ix(p+1:end-p, p+1:end-p);
Iy = Iy(p+1:end-p, p+1:end-p);



end