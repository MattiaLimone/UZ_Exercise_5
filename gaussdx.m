function g = gaussdx(sigma)
x = -round(3.0*sigma):round(3.0*sigma);
g = exp(- x.^2 /(2*sigma^2)) .*x ./ (-sqrt(pi*2)*sigma^3); % Calculate Gaussian kernel for values of x
g = g / sum(abs(g)) ; % normalisation
end