function [Rbl,Cbl]=dataprep(X,s,m,views,tau)
% BL expected return and covariance construction

R=X(s+1:end,:); % market space without delays
R2=R(:,1:m); perc=(views-R2)./R2; % percentage change

[tot1,tot2]=size(X);
Rbl=zeros(tot1-s,tot2);
Cbl{tot1-s,1}={};
P=zeros(m,tot2); 
P(1:(m+1):end)=1;
for i=1:tot1-s
    r=X(i:s+i-1,:);
    rr=r./max(r);
    Sigma=cov(rr);
    meanR=mean(rr,2);
    [~, PI] = EER(rr,meanR,Sigma);
    C=tau*Sigma;
    q=perc(i,:)';
    Omega=diag(diag((1-tau)*P*Sigma*P'));
    Cbl{i,1}=100*(pinv(P'*(Omega\P) + pinv(C)));
    Rbl(i,:)=pinv(P'*(Omega\P) + pinv(C))*( pinv(C)*PI + P'*(Omega\q));
end