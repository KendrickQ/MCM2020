% weighted score
total_cluster = max(labels);
[~, w] = size(features);

score_list = zeros(total_cluster, 1);
features_list = zeros(total_cluster, w);

for index = 0:total_cluster
    mask = (labels == index);
    cluster_weight_mask = cluster_weight(mask);
    features_mask = features(mask, :);
    score_mask = score(mask);
    
    score_weighted = sum(score_mask .* cluster_weight_mask);
    score_weighted = score_weighted / sum(cluster_weight_mask);
    
    features_weighted = cluster_weight_mask * features_mask;
    features_weighted = features_weighted / sum(cluster_weight_mask);
    
    features_list(index+1, :) = features_weighted(:);
    score_list(index+1) = score_weighted;
end

save('score.mat', 'score_list');
save('features.mat', 'features_list');

