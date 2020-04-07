function L = Decforward(x, p)
%% get variables
[x_h, x_w] = size(x);
alpha_weight = p.alpha;
beta_weight = p.beta;
features = p.features;
[f_h, f_w] = size(features);
restrict_weight = p.restrict;
scores = p.scores;
env = p.env;
N = p.N;
discount = p.discount;

%% knn: compute the score, euclidean space
x_f = repmat(sum(x.^2, 2), 1, f_h);
y_f = repmat(sum(features.^2, 2)', x_h, 1);
xy_f = x * features';
knn_mat = x_f + y_f - 2* xy_f;
[~, index] = min(knn_mat, [], 2);
scores_list = scores(index);

%% compute alpha and beta
x_ = cat(2, scores_list, x); 
alpha = x_ * alpha_weight;
beta = x_ * beta_weight;

%% time series prediction
init = 0.002;
total_step = length(env);
future_r = zeros(x_h, length(env));
for i = 1:x_h
    result = discrete_SIR(alpha(i), beta(i), init, total_step, env, false);
    future_r(i, :) = result(2:end, 2);
end
future_r = max(future_r, 0);

%% compute revenue
discount_mat = zeros(1, length(env));
for i = 1:length(env)
    discount_mat(i) = discount ^ i;
end
discount_mat = repmat(discount_mat, x_h, 1);
revenue = sum(discount_mat .* future_r, 2);
revenue = min(revenue, 1);

%% compute cost
cost = x * restrict_weight;

%% compute L
L = revenue - cost;
end
