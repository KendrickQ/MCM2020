function [ym,fym]  = psondDec(f, xlimit, vlimit, d, N, ger, w, c1, c2, parameters)
% tic
%% �����趨
if ~exist('xlimit', 'var')
    xlimit = [-3 12.1;4.1 5.8];
end
if ~exist('vlimit', 'var')
    vlimit = [-1 1;-1 1];
end
if ~exist('N', 'var')
    N = 500; % ��Ⱥ��Ŀ
end
if ~exist('d', 'var')
    d = 2;
end
if ~exist('ger', 'var')
    ger = 1000;
end
if ~exist('w', 'var')
    w = 0.8;
end
if ~exist('c1', 'var')
    c1 = 0.9;
end
if ~exist('c2', 'var')
    c2 = 0.9;
end

%% ��Ⱥ��ʼ��
x = repmat(xlimit(:,1)',N,1)+repmat(diff(xlimit'),N,1).*rand(N,d);
v = repmat(vlimit(:,1)',N,1)+repmat(diff(vlimit'),N,1).*rand(N,d);
xm = x;
fxm = -inf*ones(N,1);
ym = xlimit(:,1)'+diff(xlimit').*rand(1,d);
ym_pre = zeros(1, d);
fym = -inf;
%% ��ʼ����
MAX_COUNT = 10;
count = MAX_COUNT;
for i = 1 : ger
    if ~exist('parameters', 'var')
        y = f(x);
    else
        y = f(x, parameters);
    end
    
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
    if sum(abs(ym_pre - ym)) < 1e-7
        count = count - 1;
        if count <= 0
            break;
        end
    else
        count = MAX_COUNT;
    end
    ym_pre = ym;
end
% toc
% disp(['���Ž�Ϊ:',num2str(ym)]);
% disp(['����ֵΪ:',num2str(fym)]);
end
