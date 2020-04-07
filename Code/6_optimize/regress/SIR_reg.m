clear;
clc;

load('features.mat');
load('parameters.mat');
load('score.mat');

alpha = parameters(:, 1);
beta = parameters(:, 2);

% alpha reg
variables = cat(2, score_list, features_list);
alpha_weight = reg(variables, alpha);
save('alpha_weight.mat', 'alpha_weight');

% beta reg
beta_weight = reg(variables, beta);
save('beta_weight.mat', 'beta_weight');

