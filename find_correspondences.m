function [indices, distances] = find_correspondences(D1, D2)
len1 = size(D1, 1);
num = size(D2, 1);
distances = zeros(len1, 1);
indices = zeros(1, len1);
for i = 1:len1
    d = zeros(1, num);
    for j = 1:num
        d(j) = sqrt(sum((sqrt(D1(i, :)) - sqrt(D2(j, :))).^2)/2);
    end
    [distances(i), indices(i)] = min(d);
end
end
