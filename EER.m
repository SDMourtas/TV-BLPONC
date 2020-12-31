function [wtsMarket, PI] = EER(assetRetn, benchRetn,Sigma)
% Function for calculating the equilibrium excess returns

% Find the market portfolio.
numAssets = size(assetRetn,2);
UB = ones(1,numAssets);
LB = zeros(1,numAssets);
Aeq = ones(1,numAssets);
Beq = 1;
opts=optimset('Display','off');
wtsMarket = quadprog(2*Sigma,[],[],[],Aeq,Beq,LB,UB,[],opts);

% Find delta.
shpr = mean(benchRetn)/std(benchRetn);
delta = shpr/sqrt(wtsMarket'*Sigma*wtsMarket); 

% Compute the implied expected return.
PI = delta*Sigma*wtsMarket;