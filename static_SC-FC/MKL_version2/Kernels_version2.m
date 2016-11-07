function [ H ] = Kernels_version2( SC, m)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n = size(SC,1);
H = zeros(n,n,m);
% this code outputs correlation coefficient for multiple number of kernels
W = SC;
D = diag(sum(W+eps));
%L = D^(-0.5)*(D - W)*D^(-0.5);
iDelta = diag(sqrt(1./diag(D)));
L = iDelta*(D - W)*iDelta;
[~,lambda] = eig(L);
lambda = sort(diag(lambda));

%{
% initial method of finding scales
%{
% for dipanjan sir's data
t = logspace(log10(0.001),log10(288),p-1);
 %}
%{
 % for author's data
t = logspace(log10(0.001),log10(2),p-1); %+ rand(1,p-1); results with random scales is very poor: in range -0.1 to 0.3, 0.65 > upperbound of max correlation !
%}
%}

%%{
% formula method of finding scales
correlations = linspace(0.05,0.95,m);
t = -log(correlations)/(lambda(round(0.25*size(lambda,1)),1));
% take the 20% indexed eigen-value, then find the scales corresponding to
% these correlations
%}
t = [0,t];
for i = 1 : m
    H(:,:,i) = expm(-L*t(i));
end
end

