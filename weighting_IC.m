function [w,cr] = weighting_IC(X)
[n,m] = size(X);
P = X/sum(X(:));
id = zeros(1,m);
for j = 1:m
    p = P(:,j);
    id(j) = 1-(-sum(p.*log(p+eps))/(log(n)));
end
cc = abs(corrcoef(P));
R = m - sum(cc,2);
cr = id.*R';
w = zeros(1,m);
for i = 1:m
    w(i) = cr(i)/sum(cr(:));
end
end