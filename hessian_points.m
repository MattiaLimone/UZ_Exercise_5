function [out1, out2] = hessian_points(img, sigma, threshold)
[Ixx, Iyy, Ixy] = image_derivatives2(img, sigma);
I_hess = sigma^4 * (Ixx .* Iyy - Ixy.^2);
out1 = I_hess;
out2 = [];

if nargin > 2
    I_hess(I_hess <= threshold) = 0;
    I_hess = nonmaxima_suppression_box(I_hess, 1);
    [out2, out1] = find(I_hess);
end
end