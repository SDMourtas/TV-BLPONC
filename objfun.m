function f=objfun(p,w,x,x1)
f=x'*w*x+sum((x>x1).*(0.02+0.06*(x-x1).*p)+(x<x1).*(0.02+0.04*(x1-x).*p));