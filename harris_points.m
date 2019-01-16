function [px, py] = harris_points(img, sigma, threshold)
sigma_t = 1.6 * sigma;
alpha = 0.06;
[Ix, Iy] = image_derivatives(img, sigma);
A = gaussfilter(Ix.^2, sigma_t);
B = gaussfilter(Iy.^2, sigma_t);
C = (gaussfilter(Ix.*Iy, sigma_t));
det = A .* B - C.^2;
trace = A + B;
H = det - alpha * trace.^2;

if nargin > 2
    H(H <= threshold) = 0;
    H = nonmaxima_suppression_box(H, 1);
    [py, px] = find(H);
else
    px = H;
    py = [];
end
end