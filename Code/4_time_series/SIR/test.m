clear;clc;
tic;

alpha_list = [0.1 0.1 0.09 0.11];
beta_list = [0.05 0.04 0.05 0.06];

figure();
hold on;
for i = 1:4
    % hyper-parameters
    init = 0.01;
    alpha = alpha_list(i);
    beta = beta_list(i);
    total_step = 300;

    % test
    Nseries = ones(1, total_step+1);
    x = discrete_SIR(alpha, beta, init, total_step, Nseries, false);
    x = x(:, 2);
    plot(x);
end

title('SI-SIR model sensitivity');
legend('alpha=0.1,beta=0.05','alpha=0.1,beta=0.04','alpha=0.09,beta=0.05','alpha=0.11,beta=0.06');



toc;