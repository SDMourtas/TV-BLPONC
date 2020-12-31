function P = penfun2(x,x_minus,x_plus,A,b,p,w,K,R,x1)
% R * constraint function
f = R*sum((A*x+b<0).*(A*x+b).^2+(x_minus-x>0).*(x_minus-x).^2 ...
    +(x-x_plus>0).*(x-x_plus).^2)+R^2*(sum(x>0)>K);
% Objective function
P = objfun(p,w,x,x1)+f;  
end