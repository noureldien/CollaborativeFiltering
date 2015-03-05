% this is some analysis done over the features
% using correlation coefficient (linear correlation)

% include directories
addpath(genpath('..\Data\'));
addpath(genpath('..\Shared\'));

% load the data
load('Data\t_train.mat');
load('Data\t_test.mat');
load('Data\t_truth.mat');
% load('..\Data\fourk.mat');
% load('..\Data\fourk55.mat');
% load('..\Data\train.mat');
% load('..\Data\test.mat');

data = t_truth;
[M,N] = size(data);

% get correlation coefficients
coeffs = corrcoef(data);

% get the variances of the feature, at the end of the algorithm
% a feature is not clustered, check it's variance, if it has
% hight variance, then it's a noisy feature, neglect it
% on the other hand, if it has low variance, then it's a good
% discrimanent feature, add it to it's own cluster
vars = dataVariances(data, [99 55]);

% threshold under it, the 2 features are not considered
% correlated
threshold = 0.1;

% represents the clusters of correlated features
% each row represnet a cluster, which contains
% the index of correlated features
clusters = [];

% array telling the ids of the features that was checked for correlation
% (either picked up and clustered or thorwn away for noisiness)
checkedFeatures = [];

% loop on the coeffs of each feature
while(length(checkedFeatures) < N)
    
    % loop on the coeff unitl you reach the first un-checked feature
    for j=1:N
        if ( ~ismember(j,checkedFeatures))
            % id of un-checked feature
            featureID = j;
            break;
        end
    end
        
    % picking up coeff of new features
    feaureCoeff = coeffs(:,1);
    
    % loop on the clusters of features
    for j=1:size(clusters,1)
        isCorrelated = true;
        % loop each feature in one cluster
        for k=1:size(clusters,2)
            clusteredFeatureID = clusters(j,k);
            
            % this is important check, becuase the horizontal vectors
            % inside the clusters matrix are not of the same size
            % so, matlab will fill the small vectors with zero
            % to match the length of the bigger ones in the matrix
            % also, check if this feature is not checked yet (not clustered)
            if (clusteredFeatureID > 0)
                
                % check the differnece in correlation between
                % the current 
                
            end
        end
    end
    
end










