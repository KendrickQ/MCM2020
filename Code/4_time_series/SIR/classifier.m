alpha_list = parameters(:, 1);
beta_list = parameters(:, 2);

area_list = zeros(1, 18);
init = 0.002;
total_step = 300;
discount = 0.8;

delta_list = zeros(1, total_step)
for i = 1:total_step
    delta_list(i) = discount^(i-1)
end

for i = 1:18
    % hyper-parameters
    alpha = alpha_list(i);
    beta = beta_list(i);
    
    % test
    Nseries = ones(1, total_step+1);
    x = discrete_SIR(alpha, beta, init, total_step, Nseries, false);
    x = x(:, 2);
    x = max(x, 0);
    x = min(x, 1);
    x = x(2:end);
    area_list(i) = delta_list * x;
end
