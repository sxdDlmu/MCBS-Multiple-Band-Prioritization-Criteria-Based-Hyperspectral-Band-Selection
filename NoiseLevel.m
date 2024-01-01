function [c3,c3_sort]  = NoiseLevel(imgSrc, W, H)
%{ 
    fuction:   NoiseLevel
    Input:     imgSrc: normalized data with size N * L, 
               W and H: Width and height of each band,
    Output:    c3: NoiseLevel of the bands (normalized, The larger c3, the less noise)
               c3_sort: band priority sequence based on NoiseLevel

    Referenced to Q. Wang, Q. Li, and X. Li, "Hyperspectral band selection via adaptivesubspace partition strategy," 
%}
B = 10; % the size of block is B ¡Á B
regionSize_x = floor(W / B); 
regionSize_y = floor(H / B); 
W_Cut = regionSize_x * B;
H_Cut = regionSize_y * B;
[~,L] = size(imgSrc);
% For the hyperspectral band image that cannot be completely partitioned, it is a common practice  
% to remove some columns or rows of the band image until all the blocks of the same size are segmented

blockNumber = regionSize_x * regionSize_y; 
M = floor(blockNumber * 0.1);  % choose 10% blocks
alpha = floor((M) * 0.33);
imgSrc = reshape(imgSrc, W, H, L);
imgSrc = imgSrc(1:W_Cut,1:H_Cut,:);
for i = 1 : L
    img = imgSrc(:,:,i);
    partition = zeros(1, blockNumber);
    partition(1, randperm(blockNumber, M)) = 1;
    Block = reshape(partition, regionSize_x, regionSize_y);
    
    count = 1;
    LM = []; % local mean
    LV = []; % local variance
    for u = 1 : regionSize_x
        for v = 1 : regionSize_y
            if(Block(u,v) == 1)
                S = img((B * (u - 1) + 1):(B * u),(B * (v - 1) + 1):(B * v));
                LM(u, v) = mean(mean(S));
                mse = (S(:) - LM(u, v)).^2;
                LV(count) = sqrt(sum(mse) / (B * B - 1));
                count = count + 1;
            end
        end
    end
    lv = LV(:);
    [x,y] = hist(lv, alpha);
    [p,q] = max(x);
    max_index = y(q);
    tmp = (y(2) - y(1)) / 2;
    weight(i) = sum(lv(find((lv < max_index + tmp) & (lv > max_index - tmp)))) / p;
end
c3 = weight;
c3 = (max(c3)-c3)';
[~, c3_sort] = sort(c3, 'descend');
end

