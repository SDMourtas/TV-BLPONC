%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  BAS source codes for the TV-BLPONC problem (version 1.0 )        %
%                                                                   %
%  Developed in MATLAB R2018b                                       %
%                                                                   %
%  Author and programmer: T.E. Simos, S.D.Mourtas, V.N.Katsikis     %
%                                                                   %
%   e-Mail: tsimos.conf@gmail.com                                   %
%           spirosmourtas@gmail.com                                 %
%           vaskatsikis@econ.uoa.gr                                 %
%                                                                   %
%   Main paper: T.E. Simos, S.D.Mourtas, V.N.Katsikis,              %
%               "Time-Varying Black-Litterman Portfolio Optimization%
%               under Nonlinear Constraints via Neuronets and BAS   %
%               Algorithm," (submitted)                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

s=40;                    % number of delays for average and cov matrix
X1=xlsread('\data1');    % stocks close prices (included delays)
views=xlsread('\data1_views'); % investor views on X1 (without delays)...
                               % created by WASD-based PFN
X2=xlsread('\data2');    % more stocks close prices (included delays)

% m: number of stocks with views
% n: number of stocks without views 
% K: cardinality number
% tau: parameter which defines the total weight given to passive...
%      versus active investment views.

m=10;n=10;tau=0.1;K=8;   % Example 1: 20 stocks market, where 10 include views
%m=20;n=30;tau=0.5;K=20; % Example 2: 50 stocks market, where 20 include views
%m=30;n=60;tau=0.9;K=40; % Example 3: 90 stocks market, where 30 include views

views=views(:,1:m);
X=[X1(:,1:m) X2(:,1:n)];            % market space
xp=zeros(m+n,1); xp(1:(m+n)/2)=1/4; % given portfolio

[t,xbas,xabc,xsma,xde]=TVBLPONC(X,views,m,s,tau,K,xp);