function y = f(x)
% y = 21.5+x(:,1).*sin(4*pi*x(:,1))+x(:,2).*sin(20*pi*x(:,2));
y = - x(:, 1).^2 - x(:, 2).^2 - (x(:, 3) - 3).^2 ;
end