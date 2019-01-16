function [g, x] = gauss(sigma)
x = -round(3.0*sigma):round(3.0*sigma);
g = exp(- x.^2 /(2*sigma^2)) / (sqrt(pi*2)*sigma); % Calculate Gaussian kernel for values of x
g = g / sum(g) ; % normalisation
end