%%%% SVM demo
DS = 1; % DS 表示数据集
train_num = 500; % train_num表示所用训练样本总数
band_set = [1:10];
[class_results_SVM] = func_SVM(DS,train_num,band_set); 