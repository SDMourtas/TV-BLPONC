%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA107
% Project Title: Implementation of Differential Evolution (DE) in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function z=Sphere(u,A,p,b,w,K,x1)

    u=u';
f = 1e5*sum((A*u+b<0).*(A*u+b).^2)+1e5^2*(sum(u>0)>K); 
z = u'*w*u+sum((u>x1).*(0.02+0.06*(u-x1).*p)+(u<x1).*(0.02+0.04*(x1-u).*p))+f;

end