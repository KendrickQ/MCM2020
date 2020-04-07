clear;clc;
load('features.mat');
% load('score.mat');

[h, ~] = size(features_list);
restrict_weight = reg(features_list, ones(h, 1));
restrict_weight = (restrict_weight - min(restrict_weight)) / (max(restrict_weight) - min(restrict_weight));
save('restrict_weight.mat', 'restrict_weight');