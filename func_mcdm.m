function [bandset,re_mcdm,strd,w,X] = func_mcdm(IE,MV,N)
%{
    img:HSI，WH*L
    k: number of selected bands
    
%}
%% decision matrix
M = [IE MV N];
[n,m] = size(M);
% X = M./repmat(sum(M.*M).^0.5,n,1);
minm = min(M);
maxm = max(M);
for j = 1:m
    X(:,j) = (M(:,j)-minm(j))/(maxm(j)-minm(j)+eps);
end 

%% 
% P = X/sum(X(:));
P = X;
%% 

% [w,strd] = weighting_en(P);
% [w,strd] = weighting_sd(P);
[w,strd] = weighting_critic(P);

re_mcdm=[];dp=[];dn=[];
%% topsis
% X=P;
PIS = max(X);
NIS = min(X);
for i = 1:n
	dp(i)=sqrt(sum(w.*((X(i,:)-PIS).^2)));
    dn(i)=sqrt(sum(w.*((X(i,:)-NIS).^2)));
    re_mcdm(i) = dn(i)/(dp(i)+dn(i));
end

[~, I_mcdm] = sort(re_mcdm, 'descend');
bandset = I_mcdm(1:n);
end
