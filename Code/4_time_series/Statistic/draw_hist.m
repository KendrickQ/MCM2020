function values = draw_hist(data, edge, nbins, name, path)
h = histogram(data);

h.BinEdges = edge;
h.NumBins = nbins;
values = h.Values;
grid on;
xlabel('days');
ylabel('N');
if exist('name', 'var')
    title(name)
else
    title('default');
end

if exist('path', 'var')
    saveas(gcf, [path name '.bmp']);
end
close all;
end

