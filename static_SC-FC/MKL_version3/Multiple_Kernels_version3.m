function [ result ] = Multiple_Kernels_version3( sCall, fCall, m, epsilon, idx_lam )
%MULTIPLE_KERNELS_VERSION3 Summary of this function goes here
%   Detailed explanation goes here
% variables
result = cell(1,3);

%-------------------------------
% training
%-------------------------------
pi = training_version3(sCall, fCall, m, epsilon, idx_lam);

%-------------------------------
% testing
%-------------------------------
[FC_pred, corr] = testing_version3(sCall, fCall, m, pi, epsilon, idx_lam);

%------------------------------
% results
%------------------------------
result{1,1} = pi;
result{1,2} = corr;
result{1,3} = FC_pred;
end

