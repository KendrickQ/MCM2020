%Ğ¡ÊÀ½çÍøÂçSIR http://blog.csdn.net/sqyx008/article/details/62049395

%SIRModel.m
function y=SIRModel(t,x,lambda1,lambda2,mu,i0)
y=[-lambda1*i0*x(1)-lambda2*x(1)*x(2),(1-mu)*(lambda1*i0*x(1)+lambda2*x(1)*x(2)),mu*(lambda1*i0*x(1)+lambda2*x(1)*x(2))]';
end