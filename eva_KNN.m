function ave_acc = eva_KNN(img_src,img_gt,Y)
newData = img_src(:, Y)';
trnPer = 0.1; % 10% samples from each class based on selected bands are selected 
clsCnt = length(unique(img_gt)) - 1; 
[trnData, trnLab, tstData, tstLab] = TrainTest(newData', img_gt, trnPer, clsCnt);

tstNum = zeros(1, clsCnt);
for i = 1 : clsCnt
    index = find(tstLab == i);
    tstNum(i) = length(index);
end

k = 5; % the parameter of KNN
preLab = KNN(trnData, trnLab, tstData, tstLab, k);
ave_acc = accuracy(tstLab, preLab, clsCnt, tstNum);
disp(['Average accuracy of KNN classification: ',num2str(ave_acc)]);
end