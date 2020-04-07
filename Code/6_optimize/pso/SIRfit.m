close all;
addpath(genpath('D:\Seafile\Group\2020-C\Code\4_time_series\Statistic\time_series\paci\truth'));
addpath(genpath('D:\Seafile\Group\2020-C\Code\4_time_series\SIR'));

env = x;
env_change = zeros(1, length(env));
for i = 1:length(env)
    if i == 1
        env_change(i) = 1;
    elseif env(i-1) == 0
        env_change(i) = 1;
    elseif env(i) == 0
        env_change(i) = 1;
    else
        env_change(i) = env(i) / env(i-1);
    end
end
env_change = env_change(1:100);
            
% hyper-parameters
total_N = 8;
total_steps = 100;
number_mat = zeros(total_N+1, total_steps);
NAME = 'pacifier';
for index = 0:total_N
    data_path = [NAME '_{' num2str(index) '}'];
    load(data_path);
    for j = 1:total_steps
        number_mat(index+1, j) = values(j);
    end
end

%% normalize and smooth
number_sum = sum(number_mat);
for i = 1:length(number_sum)
    if number_sum(i) <= 100
        number_sum(i) = 100;
    end
end
number_sum = number_sum + 1e-3;
number_mat = number_mat ./ number_sum;

%% fitting and plot
parameters = zeros(total_N + 1, 2);
for index = 0:total_N
    Nseries = number_mat(index+1, :);
    enter_time = 1;
    for i = 1:length(Nseries)
        if Nseries(i) >= 0.002
            enter_time = i;
            Nseries(i) = 0.002;
            break;
        end
    end
    % smooth
    Nseries = smooth(smooth(Nseries(i:end)));

    % plot and store parameters
    plot(Nseries);
    save(['Group ' num2str(index) '.mat'], 'Nseries');
    hold on;

    xlimit = [0 3; 0 3;];
    vlimit = [-1 1;-1 1;];
    N = 500; % 种群数目
    d = 2;
    ger = 1000;
    w = 0.8;
    c1 = 0.9;
    c2 = 0.9;

    tic;
    [w, max_value] = psond(@SIRforward, xlimit, vlimit, d, N, ger, w, c1, c2, Nseries, env_change);
    toc;

    % hyper-parameters
    init = Nseries(1);
    total_step = length(Nseries) - 1;

    % test
    Nseries = ones(1, total_step+1);
    fitting_result = discrete_SIR(w(1), w(2), init, total_step, Nseries, false);

    plot(fitting_result(:, 2));
    grid on;
    xlabel('days');
    ylabel('rate');
    title(['Group ' num2str(index) ' fitting (\alpha = ' num2str(w(1)) ' \beta = ' num2str(w(2)) ')']);
    legend('true curve', 'fitting curve', 'location', 'best');
    parameters(index+1, 1) = w(1);
    parameters(index+1, 2) = w(2);
    saveas(gcf, ['Group ' num2str(index) ' fitting (' num2str(w(1)) ' ' num2str(w(2)) ').bmp']);
    close all;
end

save('parameters.mat', 'parameters');








