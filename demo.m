close all;clear;clc
nbs = 15;%number of selected bands

%% load data
load DC_Mall.mat;
[W, H, L]=size(img_src);
img_src = reshape(img_src, W * H, L);
img = zeros(W * H, L);
for i = 1 : L
    img(:, i) = img_src(:,i) / max(max(img_src(:,i)));
end

%% BS
% three band prioritization criteria
[c1,c1_sort] = IE(img);
[c2,c2_sort] = MVPCA(img);
[c3,c3_sort] = NoiseLevel(img, W, H);

band_Sort = MCBS(c1,c2,c3);
band_Set = SP_MCBS(band_Sort,img,nbs);%outcome

%% evaluation by KNN
ave_acc = eva_KNN(img,img_gt,band_Set);
