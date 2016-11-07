function [ pi ] = training_version3( sCall, fCall, m, epsilon, idx_lam  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% initializating variables
L = size(fCall,3); % number of samples
n = size(fCall,1); % number of ROIs
pi = zeros(m * n, n);
Psi = zeros(L * n, m * n);
Phi = zeros(L * n, n);

%-------------------------------
% matrix formation
%-------------------------------
for l = 1 : L
    % pre-processing
    [MapC, inds] = pre_process(sCall(:,:,l), fCall(:,:,l));
    
    % thresholding SC
    MapC = (MapC > epsilon * max(MapC(:))) .* MapC;
    
    % set of heat kernels
    % Psi and Phi formation
    K = Kernels_version3(MapC, m, idx_lam);
    Psi((l - 1) * n + 1 : l * n, :) = K;
    Phi((l - 1) * n + 1 : l * n, :) = fc_range(fCall(:,:,l), ' ') .* inds; % fc_range(fCall(:,:,l), 'normalized') .* inds;
end

%--------------------------------
% training
%--------------------------------
% % pseudo inverse of Psi
% [u, s, v] = svd(Psi);
% s = s .* (s > 0.2);
% [rows, cols] = find(s > 0);
% inv_s = [[inv(s(rows, cols)), zeros(max(rows), L * n - max(rows))]; zeros(m * n - max(rows), L * n)];
% Psi_inv = v * inv_s * u';
% 
% % find pi
% pi = Psi_inv * Phi;

% finding pi for each node
for j = 1 : n
    % Quadratic programming
    [pi(:, j), fval, exitflag, o_p, lambda] = quadprog(Psi' * Psi, -2 * Phi(:, j)' * Psi, [], [], [], [], double(zeros(m * n, 1)), double(ones(m * n, 1)));
    
    % pseudo inverse
    % pi(:, j) = (Psi' * Psi) \ (Psi' * Phi(:, j));
end

% post-processing of pi
% remove all values smaller than a threshold
pi = pi .* (pi > 1e-3);
end

