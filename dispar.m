function D = dispar(img1, img2, patchSize, dMax)
[h, w] = size(img1);
D = zeros(h, w);
img1 = double(img1);
img2 = double(img2);

for i = (1+patchSize):(h-patchSize)
    for j = (1+patchSize):(w-patchSize)
        yMin = i - patchSize;
        yMax = i + patchSize;
        xMin = j - patchSize;
        xMax = j + patchSize;
        patch = img1(yMin:yMax, xMin:xMax);
        N = (2*patchSize+1)^2;
        mPatch = mean(patch(:));
        patch = patch-mPatch;
        C = zeros(1, w);
        limitMin = max(1, j-10);
        limitMax = w;
        
        for k = j:min(j + dMax, w-patchSize)
            xMin = k - patchSize;
            xMax = k + patchSize;
            img = img2(yMin:yMax, xMin:xMax);
            mi = mean(img(:));
            img = img-mi;
            C(k) = 1/N * sum(sum((patch .* img))) / (sqrt(sum(sum(patch.^2))/N) * sqrt(sum(sum(img.^2))/N) + 1e-5);
        end
        
        x = find(C == max(C));
        D(i, j) = abs(x(1)-j);
    end
end
end