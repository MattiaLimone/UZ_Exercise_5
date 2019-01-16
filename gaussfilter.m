function result = gaussfilter(img, sigma)
g = gauss(sigma);
img = conv2(img, g.', 'same');
result = conv2(img, g, 'same');
end