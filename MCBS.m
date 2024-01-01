function band_Sort = MCBS(c1,c2,c3)
%{ 
    Reference: X. Sun, X. Shen, H. Pang and X. Fu "Multiple Band Prioritization 
               Criteria-Based-Target Band Selection for Hyperspectral Imagery,¡±
               Remote Sensing, DOI: 10.3390/rs14225679.
    Input:     c1,c2,c3: Band priority sequences based on three ranking criteria,
                         Entropy, MVPCA and noise estimation are used in our paper.                                  
    Output:    band_Sort: an band priority sequence based on multi-criteria
%}
%% Construction of the decision matrix
M = [c1 c2 c3];
[n,~] = size(M);
X = M./repmat(sum(M.*M).^0.5,n,1);%standardization

%% IC-Based Weight Estimation
[w,~] = weighting_IC(X);

%% distance to ideal solutions
PIS = max(X);
NIS = min(X);
dis_ideal=zeros(1,n);dp=zeros(1,n);dn=zeros(1,n);
wX = w.*X;
for i = 1:n
    dp(i) = norm(wX(i,:)-PIS,2);
    dn(i) = norm(wX(i,:)-NIS,2);
    dis_ideal(i) = dn(i)/(dp(i)+dn(i));
end
%% sort
[~, band_Sort] = sort(dis_ideal, 'descend');
end