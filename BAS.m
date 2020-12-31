% =========================================================% 
% BAS by X. Jiang and S. Li, \BAS: Beetle Antennae Search 
%
% Algorithm for Optimization Problems," arXiv preprint, 
%
% vol. abs/1710.10724, 2017.
%
% appropriately modified for the TV-BLPONC problem.
% ======================================================== %
function [xbest,fbest] = BAS(x0,xxpp,x_minus,x_plus,A,b,p,w,K,R,d,delta,tmax,tol)
% BAS: beetle antenna searching for global minimum 

x1=x0.*xxpp;
eta_delta=0.991;
eta_d=0.991;
k=length(x0);
%x11=-ones(size(x0));
t=0;

% iteration
while t<tmax %&& norm(penfun2(x11,xi_minus,xi_plus,A,bb,pr,w,K,R,x1)-penfun2(x0,xi_minus,xi_plus,A,bb,pr,w,K,R,x1),2)>tol
    c=rands(k,1);
    c=c/(eps+norm(c));
    xr=x0-d*c;
    xl=x0+d*c;
    x=abs(x0+delta*c*sign(penfun2(xr,x_minus,x_plus,A,b,p,w,K,R,x1)-penfun2(xl,x_minus,x_plus,A,b,p,w,K,R,x1)));
    x=x.*xxpp;
    if penfun2(x,x_minus,x_plus,A,b,p,w,K,R,x1)<penfun2(x0,x_minus,x_plus,A,b,p,w,K,R,x1)
        %x11=x0;
        x0=x; 
    end
    delta=eta_delta*delta;
    d=eta_d*d+0.001;
    t=t+1;
end
xbest=x0;
fbest=objfun(p,w,xbest,x1);