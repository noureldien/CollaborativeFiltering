% the same as exp 28 but applied on real train + test77 instead
% of applying to t_train, t_test

clc;

% % load data
% load('Data\train.mat');
% load('Data\trainKnn.mat');
% load('Data\testKnn.mat');
% load('Data\test.mat');
% load('Data\test77.mat');
% 
% instrad of doing the following step, just load
% the trainKnnAdj
% % loop on the trainKnn
% % check if each user has correlation with at leat 10
% % if so, re-do the estimating (using matrix completiton) with
% % only those correlated users
% % calcuate the correlation
% corrs = corr(trainKnn', trainKnn', 'type', 'pearson');
% trainCorr = [];
% trainKnnAdj = trainKnn;
% for i=1:size(trainKnn,1)
%     uIdx = find(corrs(i,:) > 0.67);
%     uCount = length(uIdx);
%     disp(strcat('User: ', num2str(i), ', Cluster: ', num2str(uCount)));
%     % if w've enough train users correlated to the current test
%     % the add the current test to them and do prediction
%     if (uCount >= 10)
%         trainCorr = [trainCorr, i];
%         % do prediction only on 10 train users
%         uTrain = train(uIdx(1:10),:);
%         mu = 0.001;
%         trainKnnAdj(i,:) = dataPrediction(uTrain, train(i,:),[], [99], mu);
%     end
% end

% copy the 77 from the test77 to testKnn
test99 = testKnn;
test99(test77==77) = 77;

% estimating using Knn
data = [trainKnnAdj; test99];
 
% estimate the 77 for test using matrix completiton
estm = dataCompletion(data, [77]);
 
% split train and test
offsetTr = size(train,1);
offsetTs = offsetTr + 1;
train99 = data(1:offsetTr,:);
test99 = data(offsetTs:end,:);

% get only the estimate of the test
estm_ =  estm(offsetTs:end,:);

[~, rmse, ~] = calcError(testKnn, test99, estm_, [77]);
rmse








