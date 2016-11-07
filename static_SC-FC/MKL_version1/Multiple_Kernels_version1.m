function [ result ] = Multiple_Kernels_version1( sCall, fCall, m, epsilon, idx_lam )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%-------------------------------
% training
%-------------------------------
alpha = training_version1(sCall, fCall, m, epsilon, idx_lam);

%-------------------------------
% testing
%-------------------------------
[ FC_pred, corr ] = testing_version3(sCall, fCall, m, alpha, epsilon, idx_lam);

result{1, 1} = alpha;
result{1, 2} = corr;
result{1, 3} = FC_pred;
end

