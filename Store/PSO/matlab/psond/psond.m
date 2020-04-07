clc;clear;close all;tic
%% 参数设定
N = 500;
d = 2;
ger = 1000;
w = 0.8;
c1 = 0.9;
c2 = 0.9;
xlimit = [-3 12.1;4.1 5.8];
vlimit = [-1 1;-1 1];
%% 种群初始化
x = repmat(xlimit(:,1)',N,1)+repmat(diff(xlimit'),N,1).*rand(N,d);
v = repmat(vlimit(:,1)',N,1)+repmat(diff(vlimit'),N,1).*rand(N,d);
xm = x;
fxm = -inf*ones(N,1);
ym = xlimit(:,1)'+diff(xlimit').*rand(1,d);
fym = -inf;
%% 开始搜索
for i = 1 : ger
    y = f(x);
    for j = 1 : N
        if y(j)>fxm(j)
            fxm(j)=y(j);
            xm(j,:) = x(j,:);
            if y(j)>fym
                fym = y(j);
                ym = x(j,:);
            end
        end
    end
    v = w*v+c1*rand*(xm-x)+c2*rand*(repmat(ym,N,1)-x);
    x = x+v;
    x = min(x,repmat(xlimit(:,2)',N,1));
    x = max(x,repmat(xlimit(:,1)',N,1));
    v = min(v,repmat(vlimit(:,2)',N,1));
    v = max(v,repmat(vlimit(:,1)',N,1));
end
toc
disp(['最优解为:',num2str(ym)]);
disp(['最优值为:',num2str(fym)]);
