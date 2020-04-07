close all;clear;clc;
addpath(genpath('D:\Seafile\Group\2020-C\Code\4_time_series\SIR'));

load('features.mat');
load('predict.mat');
load('restrict_weight.mat');
load('alpha_weight.mat');
load('beta_weight.mat');
load('score.mat');

%% parameters
N = 10;
discount = 0.8;
env = x(end - N + 1:end);
env_increase = zeros(1, length(env)-1);
for i = 1:(length(env)-1)
    if env(i) ~= 0
        env_increase(i) = env(i+1) / env(i);
    else
        env_increase(i) = 1;
    end
end

parameters.alpha = alpha_weight;
parameters.beta = beta_weight;
parameters.features = features_list;
parameters.restrict = restrict_weight;
parameters.env = env_increase;
parameters.scores = score_list;
parameters.N = N;
parameters.discount = discount;

%% optimize
N = 500; % 种群数目
d = length(restrict_weight);
xlimit = [0 1];
xlimit = repmat(xlimit, d, 1);
vlimit = [-1 1];
vlimit = repmat(vlimit, d, 1);
ger = 1000;
w = 0.8;
c1 = 0.9;
c2 = 0.9;

iteration = 100;
w_total = zeros(iteration, d);
value_total = zeros(iteration, 1);
tic;
for i = 1:iteration
    disp(i);
    [weight, max_value] = psondDec(@Decforward, xlimit, vlimit, d, N, ger, w, c1, c2, parameters);
    w_total(i, :) = weight;
    value_total(i) = max_value;
end
toc;

w = value_total' * w_total;
w = w / sum(value_total);
max_value = mean(max_value);

advise.weight = w;
advise.max_value = max_value;
save('investment-advise.mat', 'advise');
disp(w);
disp(max_value);