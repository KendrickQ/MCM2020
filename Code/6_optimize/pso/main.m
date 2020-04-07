% load path
addpath(genpath('D:\Seafile\Group\2020-C\Code\4_time_series'));

xlimit = [-5 5; -5 5; -5 5;];
vlimit = [-1 1;-1 1; -1, 1];
N = 500; % 种群数目
d = 3;
ger = 1000;
w = 0.8;
c1 = 0.9;
c2 = 0.9;
[w, value] = psond(@f, xlimit, vlimit, d, N, ger, w, c1, c2);