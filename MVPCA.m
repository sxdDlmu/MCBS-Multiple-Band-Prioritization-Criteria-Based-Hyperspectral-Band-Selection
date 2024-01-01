function [c2, c2_sort] = MVPCA( X )
%{ 
    fuction:   Maximum variance principal component analysis
    Input:     X: normalized data with size N * L,                   
    Output:    c2: variance of the bands
               c2_sort: band priority sequence based on MVPCA
%}
X = X';
[L, ~] = size(X);
for i = 1 : L
    X(i, :) = X(i, :) - mean(X(i, :));
end
XXt = X * X';
rnk_val = diag(XXt);
[temp_rank, I] = sort(rnk_val, 'descend');
for i = 1 : L
    rnk_val(I(i)) = temp_rank(i);
end
c2 = rnk_val;
c2_sort = I;
end

