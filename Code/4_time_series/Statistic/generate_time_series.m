edge = [0 max(dates)];
nbins = 100;
PATH = './results/';
CLASS = 'pacifier'; % hair-dryer microwave pacifier
NAME = [CLASS ' (total)'];
V_NAME = 'values';

% total time series
values = draw_hist(dates, edge, nbins, NAME, PATH);
save([PATH NAME '.mat'], V_NAME);

% partial time series
total_groups = max(labels) + 1;
for i = 0:(total_groups - 1)
    % mask select
    mask = (labels == i);
    dates_masked = dates(mask);
    values = draw_hist(dates_masked, edge, nbins, [CLASS '_{' num2str(i) '}'], PATH);
    save([PATH CLASS '_{' num2str(i) '}.mat'], V_NAME);
end