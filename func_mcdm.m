function [bandset,re_mcdm,strd,w,X] = func_mcdm(IE,MV,N)
%{
    img:HSI，WH*L
    k: number of selected bands
    
%}
%% 构造矩阵
M = [IE MV N];%评分矩阵
[n,m] = size(M);
% X = M./repmat(sum(M.*M).^0.5,n,1);%标准化1
minm = min(M);
maxm = max(M);
for j = 1:m
    X(:,j) = (M(:,j)-minm(j))/(maxm(j)-minm(j)+eps);
end %标准化2

%% 概率矩阵
% P = X/sum(X(:));
P = X;
%% 构造权重矩阵

% [w,strd] = weighting_en(P);%计算权重-熵
% [w,strd] = weighting_sd(P);%计算权重-标准差
[w,strd] = weighting_critic(P);

re_mcdm=[];dp=[];dn=[];
%% topsis1
% X=P;
PIS = max(X);
NIS = min(X);
for i = 1:n
	dp(i)=sqrt(sum(w.*((X(i,:)-PIS).^2)));
    dn(i)=sqrt(sum(w.*((X(i,:)-NIS).^2)));
    re_mcdm(i) = dn(i)/(dp(i)+dn(i));
end
%% topsis2
% X2 = w.*X;
% PIS = max(X2);
% NIS = min(X2);
% for i = 1:n
%     dp(i) = norm(X2(i,:)-PIS,2);
%     dn(i) = norm(X2(i,:)-NIS,2);
%     re_mcdm(i) = dn(i)/(dp(i)+dn(i));
% %     re_mcdm(i) = sum(X2(i,:))
% end
%% sort
[~, I_mcdm] = sort(re_mcdm, 'descend');
bandset = I_mcdm(1:n);
end