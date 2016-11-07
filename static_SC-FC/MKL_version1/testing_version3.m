function [ FC_pred, corr ] = testing_version3( sCall, fCall, m, alpha, epsilon, idx_lam )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%-------------------------------
% testing
%-------------------------------
[~, n, L] = size(sCall);
FC_pred = zeros(n, n, L);
corr = zeros(1, L);

for l = 1 : L
    % pre-process
    [MapC, inds] = pre_process(sCall(:,:,l), fCall(:,:,l));
    
    % thresholding SC
    MapC = (MapC > epsilon * max(MapC(:))) .* MapC;
    
    % heat kernels
    X = Kernels_version1(MapC,m, idx_lam);
    
    % prediction
    FC_pred(:, :, l) = reshape((X * alpha), [n, n]);
%     FC_pred(:, :, l) = (FC_pred(:, :, l) + FC_pred(:, :, l)') / 2;
    
    % correlation
    % c = corrcoef(FC_pred(:, :, l) .* inds, fc_range(fCall(:, :, l), 'normalized') .* inds);
    c = corrcoef(FC_pred(:, :, l) .* inds, fc_range(fCall(:, :, l), '') .* inds);
    corr(1,l) = c(1,2);
end
end

