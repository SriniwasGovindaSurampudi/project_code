function [ alpha ] = training_version1( sCall, fCall, m, epsilon, idx_lam  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% initializating variables
L = size(fCall,3); % number of samples
n = size(fCall,1); % number of ROIs
% X = zeros(n * n, m);
% Y = zeros(n * n, 1);
Psi = zeros(L * n * n, m);
Phi = zeros(L * n * n, 1);

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
    X = Kernels_version1(MapC, m, idx_lam);
    Psi(1 + (l - 1) * n * n : (l) * n * n, :) = X;
    Y = fc_range(fCall(:,:,l), ' ') .* inds; % fc_range(fCall(:,:,l), 'normalized') .* inds;
    Phi(1 + (l - 1) * n * n : (l) * n * n, :) = reshape(Y, [n * n, 1]);
end

%-------------------------------
% training
%-------------------------------
%{
H = Psi' * Psi / 2; f = -2 * Phi' * Psi;
A = []; b = [];
Aeq = ones(m, 1)'; beq = 1;
lb = zeros(m, 1); ub = ones(m, 1);
alpha = quadprog(H, f, A, b, Aeq, beq, lb, ub);
%}

%%{
alpha = (Psi' * Psi) \ (Psi' * Phi);
alpha = alpha / sum(alpha);
% alpha = (alpha - min(alpha)) / (max(alpha) - min(alpha));
%}
end