function band_Set = SP_MCBS(band_Sort,img,K)
%{ 
    Reference: X. Sun, X. Shen, H. Pang and X. Fu "Multiple Band Prioritization 
               Criteria-Based-Target Band Selection for Hyperspectral Imagery,”
               Remote Sensing, DOI: 10.3390/rs14225679.

    Input:     img: normalized data set with size L * N, 
               band_Sort: band priority sequence based on MCBS
               K: number of the selected bands
                                  
    Output:    band_Set: an optimal subset of bands
%}
K = K+1;
[~,L] = size(img);
CD_Matrix = 1 - abs(corrcoef(img));
P = SP(CD_Matrix, L, K);

rank = flipud(band_Sort);
A = zeros(K-1,L);
for i = 1 : K - 1
    for j = P(i) : P(i+1)-1
        A(i,j) = find(rank == j);
    end
end
A(i,L) = find(rank == L);
[ ~ ,band_Set]=max(A,[],2);
disp(['optimal subset of bands:',newline,num2str(band_Set')]);
end