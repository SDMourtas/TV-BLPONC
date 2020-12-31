function [x_minus,x_plus,A,b,p,w]=problem(t,X,Rbl,Cbl,x1)
n=size(Rbl,2);
w=Cbl{t+1};   % variance
A=Rbl(t+1,:); % expected return
b=-(max(A)+min(A))/2; % target price
p=X(t+1,:)';  % market price
x_plus=x1'*p./p;    % upper limit
x_minus=zeros(n,1); % lower limit