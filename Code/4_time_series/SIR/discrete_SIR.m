function x = discrete_SIR(alpha, beta, init, total_step, Nseries, isplot)
% initiation
x = zeros(total_step + 1, 3);
x(1, 1) = 1;
x(1, 2) = init;
x(1, 3) = 0;

% total competitor: default uniform distribution
N_increase_rate = Nseries;

% simulation
for i = 1:total_step
    x_1 = x(i, 1) - alpha * x(i, 1) * x(i, 2);
    x_2 = x(i, 2) + alpha * x(i, 1) * x(i, 2) - beta * x(i, 2) * x(i, 3) * N_increase_rate(i);
    x_3 = x(i, 3) + beta * x(i, 2);
    x_total = x_1 + x_2 + x_3;
    x(i+1, 1) = x_1 / x_total;
    x(i+1, 2) = x_2 / x_total;
    x(i+1, 3) = x_3 / x_total;
end

% plot
if isplot
    t = 1:(total_step + 1);
    plot(t,x(:,1),t,x(:,2),'.',t,x(:,3),'*');
    xlabel('time');
    ylabel('rate');
    legend('S','I','R');
end

end
    
