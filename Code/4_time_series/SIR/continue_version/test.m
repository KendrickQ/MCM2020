%Command Window ����������ҳ����
ts=0:1:100;
lambda1=500;
lambda2=20;
mu=0.9925;
i0=5e-7;
x0=[1,0,0];
[t,x] = ode45(@(t,x) SIRModel(t,x,lambda1,lambda2,mu,i0), ts, x0);
plot(t,x(:,1),t,x(:,2),'.',t,x(:,3),'*');
xlabel('ʱ��/��');
ylabel('����');
legend('�׸нڵ�','�����ڵ�','�Ƴ��ڵ�');
title('��1=500����2=20����=99.25%');