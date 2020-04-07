function w = reg(x, b)
% for three situations
% OLS: x = (W^T * W)^-1 * W^T * b 
[x_h, x_w] = size(x);
b_l = length(b);

if x_w < b_l
    w = (x' * x)^-1 * x' * b;
else
    w = pinv(x) * b;
end
end