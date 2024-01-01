function [c1,c1_sort] = Entrop(X)
%{ 
    fuction:   information entropy
    Input:     X: normalized data with size N * L,                   
    Output:    c1: entropy of the bands
               c1_sort: band priority sequence based on information entropy
%}

X = X';
G = 256;
[L, N] = size(X);
H = zeros(L, 1);
minX = min(X(:));
maxX = max(X(:));
edge = linspace(minX, maxX, G);
for i = 1 : L
    histX = hist(X(i, :), edge) / N;
    H (i) = - histX * log(histX + eps)';
end
c1 = H;
[~, c1_sort] = sort(c1, 'descend');
end
