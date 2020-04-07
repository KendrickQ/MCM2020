x = zeros(1,200);
for i = 0:99
    x(2*i+1) = i/100;
    x(2*i+2) = i/99;
end
t=1:200;
plot(t,x); 
xlabel('分度值i');
ylabel('电压U/V');

