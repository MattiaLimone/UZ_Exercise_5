function B = nonmaxima_suppression_box(A, N)
[h, w] = size(A);
B = zeros(size(A));
[x, y] = find(A);
for i = 1:length(x)
        i_left = max([1, y(i) - N]);
        i_right = min([w, y(i) + N]);
        i_up = max([1, x(i) - N]);
        i_down = min([h, x(i) + N]);
        kernel = A(i_up:i_down, i_left:i_right);
        if(A(x(i), y(i)) == max(max(kernel)))
            B(x(i), y(i)) = A(x(i), y(i));
        end
end
end