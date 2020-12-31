% =========================================================% 
% The TV-BLPONC problem setup and main procedure
%
% by T.E. Simos, S.D.Mourtas, V.N.Katsikis
% ======================================================== %
function [t,xbas,xabc,xsma,xde]=TVBLPONC(X,views,m,s,tau,K,xp)

% Rbl and Cbl construction
[Rbl,Cbl]=dataprep(X,s,m,views,tau);
X=X(s+1:end,:); % remove delays from market space

[tot,n]=size(X);
t=0:tot-1;

% BAS solutions
xbas=zeros(n,tot);fbas=zeros(1,tot);
tic
[x_minus,x_plus,A,b,p,w]=problem(t(1),X,Rbl,Cbl,xp);
xxp=xp;xxp(xxp>0)=1;
xxpp=BBAS(xxp,A,b,p,w,K,1e5,1e3,1e-6);
xbas(:,1)=BAS(xp,xxpp,x_minus,x_plus,A,b,p,w,K,1e5,0.2,0.5,1e3,1e-6);
fbas(1)=objfun(p,w,xbas(:,1),xp);
for k=2:tot
    [x_minus,x_plus,A,b,p,w]=problem(t(k),X,Rbl,Cbl,xbas(:,k-1));
    xxp=xbas(:,k-1);xxp(xxp>0)=1;
    xxpp=BBAS(xxp,A,b,p,w,K,1e5,1e3,1e-6);
    xbas(:,k)=BAS(xbas(:,k-1),xxpp,x_minus,x_plus,A,b,p,w,K,1e5,0.2,0.5,1e3,1e-6);
    fbas(k)=objfun(p,w,xbas(:,k),xbas(:,k-1));
end
toc

% ABC solutions
xabc=zeros(n,tot);fabc=zeros(1,tot);
tic
[x_minus,x_plus,A,b,p,w]=problem(t(1),X,Rbl,Cbl,xp);
xabc(:,1)=abc(A,p,b,w,K,x_minus',x_plus',xp)';
fabc(1)=objfun(p,w,xabc(:,1),xp);
for k=2:tot
[x_minus,x_plus,A,b,p,w]=problem(t(k),X,Rbl,Cbl,xabc(:,k-1));
xabc(:,k)=abc(A,p,b,w,K,x_minus',x_plus',xabc(:,k-1))';
fabc(k)=objfun(p,w,xabc(:,k),xabc(:,k-1));
end
toc

% SMA solutions
xsma=zeros(n,tot);fsma=zeros(1,tot);
tic
[x_minus,x_plus,A,b,p,w]=problem(t(1),X,Rbl,Cbl,xp);
xsma(:,1)=SMA(30,1000,x_minus',x_plus',length(p),@(x)Sphere(x,A,p,b,w,K,xp))';
fsma(1)=objfun(p,w,xsma(:,1),xp);
for k=2:tot
[x_minus,x_plus,A,b,p,w]=problem(t(k),X,Rbl,Cbl,xsma(:,k-1));
xsma(:,k)=SMA(30,1000,x_minus',x_plus',length(p),@(x)Sphere(x,A,p,b,w,K,xsma(:,k-1)))';
fsma(k)=objfun(p,w,xsma(:,k),xsma(:,k-1));
end
toc

% DE solutions
xde=zeros(n,tot);fde=zeros(1,tot);
tic
[x_minus,x_plus,A,b,p,w]=problem(t(1),X,Rbl,Cbl,xp);
xde(:,1)=de(A,p,b,w,K,xp,x_minus',x_plus')';
fde(1)=objfun(p,w,xde(:,1),xp);
for k=2:tot
[x_minus,x_plus,A,b,p,w]=problem(t(k),X,Rbl,Cbl,xde(:,k-1));
xde(:,k)=de(A,p,b,w,K,xde(:,k-1),x_minus',x_plus')';
fde(k)=objfun(p,w,xde(:,k),xde(:,k-1));
end
toc

% figures
erxbas=zeros(1,tot);erxabc=zeros(1,tot);
erxsma=zeros(1,tot);erxde=zeros(1,tot);
varxbas=zeros(1,tot);varxabc=zeros(1,tot);
varxtsma=zeros(1,tot);varxde=zeros(1,tot);
B=zeros(tot,1);
for i=1:tot
    erxbas(i)=xbas(:,i)'*Rbl(i,:)';
    erxabc(i)=xabc(:,i)'*Rbl(i,:)';
    erxsma(i)=xsma(:,i)'*Rbl(i,:)';
    erxde(i)=xde(:,i)'*Rbl(i,:)';
    varxbas(i)=xbas(:,i)'*Cbl{i}*xbas(:,i);
    varxabc(i)=xabc(:,i)'*Cbl{i}*xabc(:,i);
    varxtsma(i)=xsma(:,i)'*Cbl{i}*xsma(:,i);
    varxde(i)=xde(:,i)'*Cbl{i}*xde(:,i);
    [~,~,~,b,~,~]=problem(t(i),X,Rbl,Cbl,xp);
    B(i)=-b;
end

figure
plot(t,erxbas);hold on
plot(t,erxabc,':r')
plot(t,erxsma,'--g')
plot(t,erxde,'-.m')
plot(t,B,'k')
ylabel('Portfolios Expected Returns')
xlabel('Time')
xticks([0 10 20 30 40 49])
xticklabels({'1/7','16/7','30/7','13/8','27/8','10/9'})
legend('BAS','ABC','SMA','DE','Target price')
hold off

figure
plot(t,varxbas);hold on
plot(t,varxabc,':r')
plot(t,varxtsma,'--g')
plot(t,varxde,'-.m')
ylabel('Variance %')
xlabel('Time')
xticks([0 10 20 30 40 49])
xticklabels({'1/7','16/7','30/7','13/8','27/8','10/9'})
legend('BAS','ABC','SMA','DE')
hold off

figure
plot(t,abs(fbas-varxbas));hold on
plot(t,abs(fabc-varxabc),':r')
plot(t,abs(fsma-varxtsma),'--g')
plot(t,abs(fde-varxde),'-.m')
ylabel('Transaction Costs')
xlabel('Time')
xticks([0 10 20 30 40 49])
xticklabels({'1/7','16/7','30/7','13/8','27/8','10/9'})
legend('BAS','ABC','SMA','DE')
hold off

figure
Y=[mean(fbas);mean(fabc);mean(fsma);mean(fde)];
bar(Y);
text(1:length(Y),Y,num2str(Y),'vert','bottom','horiz','center'); 
box off
ylabel('Average Transaction Costs + Variance')
xlabel('Portfolio')
xticklabels({'BAS','ABC','SMA','DE'})
hold off