mask = (labels >= 0);
label_masked = labels(mask);
features_masked = features(mask, :);

% label_cell = cell(1, length(label_masked));
% for i = 1:length(label_masked)
%     content = {['group ', num2str(label_masked(i))]};
%     label_cell(i) = content;
% end
% label_cell = label_cell(:);

tic
Y = tsne(features_masked);
gscatter(Y(:,1),Y(:,2),label_masked)
toc

NAME = 'pacifier';
grid on;
title(['tsne visualization for ' NAME]);
saveas(gcf, ['tsne-' NAME '.bmp']);
