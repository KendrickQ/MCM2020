% https://blog.csdn.net/qq_41380950/article/details/100032794
close all;
%% ʱ������Ԥ��
A = values;
%�ж��Ƿ�ƽ�ȣ�ʹ��ADF����
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
m1 = length(A); %ԭʼ�����ݵĸ���
for i = s+1:m1
    y(i-s) = x(i) - x(i-s);%�������ڲ�ֱ任
end
ToEstMd = arima('ARLags',10,'MALags',5,'Constant',0);%ָ��ģ�͵Ľṹ
EstMd = estimate(ToEstMd,w');%ģ����� 
w_Forecast = forecast(EstMd,n,'Y0',w');
yhat = y(end) + cumsum(w_Forecast); %һ�ײ�ֵĻ�ԭֵ
for j = 1:n
    x(m1 + j) = yhat(j) + x(m1+j-s); %x��Ԥ��ֵ
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