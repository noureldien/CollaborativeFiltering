% like experiment 26 except using
% t_trainKnn+t_testAvg instead of t_trainAverage
% using train filled by Knn instrad of average is better
% rmse = 4.3407 (Knn is slightly better than averaging)

% now, investigate readjusting the prediction by doing
% local estimates (i.e. doing estimates on 1 test + correlated train ones).
% we estimate the 55, 99 of test indiviually
% rmse = 4.3441

%like the previous step, but estimating only 55 instead of 55, 99
% rmse = 4.3414

% from current exp (27) and previous one (26), local estimates fail

clc;

% % load data
% load('Data\t_train.mat');
% load('Data\t_truth.mat');
% load('Data\t_test55.mat');
% load('Data\t_trainKnn.mat');
%
% % we can't use t_testKnn because it's the same as the truth
% % but we can use testAvg istead of it
% t_test99 = averageCompletion(t_test55, [99]);
% 
% % estimating using Knn
% estm99 = [t_trainKnn; t_test99];
% 
% % estimate the 55 for test using matrix completiton
% estm = dataCompletion(estm99, [55]);
% 
% % split train and test
% offsetTr = size(t_train,1);
% offsetTs = offsetTr + 1;
% train99 = estm99(1:offsetTr,:);
% test99 = estm99(offsetTs:end,:);
% 
% % get only the estimate of the test
% estm =  estm(offsetTs:end,:);
% 
% [~, rmse, ~] = calcError(t_truth, t_test55, estm,[55 99]);
% rmse

% calcuate the correlation
corrs = corr(train99', estm', 'type', 'pearson');

% loop on the estimated test data
% check if each user has correlation with at leat 10 from train
% if so, re-do the estimating (using matrix completiton) with
% only those correlated users

testCorr = [];
estmAdj = estm;
for i=1:size(estm,1)
    uIdx = find(corrs(i,:) > 0.65);    
    uCount = length(uIdx);
    disp(strcat('User: ', num2str(i), ', Cluster: ', num2str(uCount)));
    % if w've enough train users correlated to the current test
    % the add the current test to them and do prediction
    if (uCount > 10)
        testCorr = [testCorr, i];
        uTrain = train99(uIdx,:);
        estmAdj(i,:) = dataPrediction(uTrain, test99(i,:),[], [55]);
    end
end

[~, rmse, ~] = calcError(t_truth, t_test55, estm,[55 99]);
rmse

[~, rmseAdj, ~] = calcError(t_truth, test99, estmAdj,[55]);
rmseAdj









