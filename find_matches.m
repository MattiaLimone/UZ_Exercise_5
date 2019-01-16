function M = find_matches(img1, img2, m, detector)
if size(img1, 3) > 1 % Make sure image is in grayscale
    img1 = rgb2gray(img1);
    img2 = rgb2gray(img2);
end

bins = 16;

sigma = 3;
t = 100;

if nargin < 3
    m = 41; % Defaulf settings
end
if nargin < 4
    detector = 'harris'; % Default settings
end
switch detector
    case 'harris'
        [px1, py1] = harris_points(img1, sigma, t);
        D1 = descriptors_maglap(img1, px1, py1, m, sigma, bins);
        [px2, py2] = harris_points(img2, sigma, t);
        D2 = descriptors_maglap(img2, px2, py2, m, sigma, bins);
    case 'hessian'
        [px1, py1] = hessian_points(img1, sigma, t);
        D1 = descriptors_maglap(img1, px1, py1, m, sigma, bins);
        [px2, py2] = hessian_points(img2, sigma, t);
        D2 = descriptors_maglap(img2, px2, py2, m, sigma, bins);
    otherwise
        error('Unknown descriptor type!');
end

[indices1to2, distances] = find_correspondences(D1, D2);
[indices2to1, ~] = find_correspondences(D2, D1);

sym =  (1:length(px1)) == indices2to1(indices1to2);
M = [px1(sym) py1(sym) px2(indices1to2(sym)) py2(indices1to2(sym)) distances(sym)]; % Take only symmetric correspondences
M = sortrows(M, 5); % Return sorted correspondences
end