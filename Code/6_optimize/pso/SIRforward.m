% this function works for fitting the discrete points through SIR model
% Args:
%   x:  2D. [alpha, beta]

function mse_error = SIRforward(x, Nseries, env_change)
% load package
addpath(genpath('D:\Seafile\Group\2020-C\Code\4_time_series\SIR'));

[x_h, ~] = size(x);
init = Nseries(1);
mse_error = zeros(x_h, 1);
for i = 1:x_h
    % hyper-parameters
    alpha = x(i, 1);
    beta = x(i, 2);
    total_step = length(Nseries) - 1;

    % test
    t = env_change;
    series = discrete_SIR(alpha, beta, init, total_step, t, false);

    % compute the MSE error
    Rseries = series(:, 2);
    mse_error(i) = - sum((Rseries(:) - Nseries(:)).^2);
end

end