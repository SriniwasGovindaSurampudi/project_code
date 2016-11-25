function [ FC_pred, corr ] = testing_version3( sCall, fCall, num_scls, pi, epsilon, idx_lam )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% variables
[~, n, L] = size(sCall);
% K = zeros(n, m * n);
FC_pred = zeros(n, n, L);
corr = zeros(1, L);

% for each sample
for l = 1 : L
    % pre-process
    [MapC, inds] = pre_process(sCall(:,:,l), fCall(:,:,l));
    
    % thresholding SC
    MapC = (MapC > epsilon * max(MapC(:))) .* MapC;
    
    % heat kernels
    K = Kernels_version3(MapC, num_scls, idx_lam);
    
    % prediction
    FC_pred(:, :, l) = (K * pi);
    FC_pred(:, :, l) = (FC_pred(:, :, l) + FC_pred(:, :, l)') / 2;
    
    % correlation
    % c = corrcoef(FC_pred(:, :, l) .* inds, fc_range(fCall(:, :, l), 'normalized') .* inds);
    c = corrcoef(FC_pred(:, :, l) .* inds, fc_range(fCall(:, :, l), '') .* inds);
    corr(1,l) = c(1,2);
end

end

