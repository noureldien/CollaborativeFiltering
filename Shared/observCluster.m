function [ indeces, clusterCount ] = observCluster( data, distances, distanceThreshold, varThreshold )

% group features into clusters, each cluster has a group
% of similar features, where the rmse between any pair of features
% in one cluster is less than or equal to the given threshold
%
% input:
%         data      : M*N, where M observations, N features
% distanceThreshold : over this threshold, the 2 features are not considered correlated
%                     because the l2 distance between them is highter than the thresold
%      varThreshold : a feature with variance over it is considered noisy and not picked up in the cluster
%
% output:
%          indeces : which feature got assigned to which cluster
%     clusterCount : number of clusters

[M,N] = size(data);

% get the variances of the feature, at the end of the algorithm
% a feature is not clustered, check it's variance, if it has
% hight variance, then it's a noisy feature, neglect it
% on the other hand, if it has low variance, then it's a good
% discrimanent feature, add it to it's own cluster
vars = dataVariances(data, []);

% array represents the clusters
% so for example the element no 12 in the array is equal to 5
% that means feature 12 is assigned to cluster 5
indeces = zeros(N,1);

% count the number of created clusters so far
clusterCount = 0;

disp('Start Clustering');

% loop on the coeffs of the features
for i=1:N
    disp(i);
    isCorrelated = false;
    % loop on the clusters of features
    for j=1:clusterCount
        
        % get ids (indeces) of features that are assigned to
        % the current cluster
        idx = find(indeces==j);
        
        % loop on the features in the current cluster
        for k=1:size(idx,1)
            
            % check the error between the current feature
            % and the clustered feature is below threshold
            isCorrelated = distances(idx(k),i) <= distanceThreshold;
            
            % if only one clustered feature is not correlated
            % with the current feature, then the current feature
            % is not correlated with all the cluster
            if (~isCorrelated)
                break;
            end
        end
        
        % break if correlation is found
        if (isCorrelated)
            break;
        end
        
    end
    
    % now, if there is correlation
    % then add the feature to the cluster
    if (isCorrelated)
        indeces(i) = j;
    else
        % if no correlation is found, then check if
        % the feature is noisy or not, by checking it's variance
        % if it is noisy, then add it in a new cluster
        if (vars(i) <= varThreshold)
            clusterCount = clusterCount + 1;
            indeces(i) = clusterCount;
        end
    end
    
end

end