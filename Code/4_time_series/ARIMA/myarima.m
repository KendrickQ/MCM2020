% https://blog.csdn.net/qq_41380950/article/details/100032794
close all;
%% 时间序列预测
A = values;
%判断是否平稳，使用ADF检验
h = adftest(A);
%B = dtrend(A)
B = diff(A);
H = adftest(B);
figure(1);
autocorr(B);
figure(2);
parcorr(B);
x = A;
w = B;
n = 10;
s = 1;
m1 = length(A); %原始的数据的个数
for i = s+1:m1
    y(i-s) = x(i) - x(i-s);%进行周期差分变换
end
ToEstMd = arima('ARLags',10,'MALags',5,'Constant',0);%指定模型的结构
EstMd = estimate(ToEstMd,w');%模型拟合 
w_Forecast = forecast(EstMd,n,'Y0',w');
yhat = y(end) + cumsum(w_Forecast); %一阶差分的还原值
for j = 1:n
    x(m1 + j) = yhat(j) + x(m1+j-s); %x的预测值
end
x(1:end)
figure(3);
t = 1:(n + m1);
t0 = 1:m1;
scatter(t, x);
hold on;
grid on;
scatter(t0, A, '+');
legend('prediction', 'truth', 'location', 'best');
NAME = 'hair-dryer';
title([NAME ' prediction']);
xlabel('days');
ylabel('N');
saveas(gcf, [NAME '-prediction.bmp']);
close all;
save('predict.mat', 'x');