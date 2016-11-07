function [ K ] = Kernels_version3( W, num_scls, idx_lam )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% variables
n = size(W,1);
K = zeros(n, num_scls * n);

% normalized laplacian, eigen decompsition
[ L, U, lambda ] = laplacian( W );

% scale selection
exp_values = linspace(0.01, 0.95, num_scls);
scls = - log(exp_values) / lambda(round(idx_lam), 1);

% computing heat kernels
for i = 1 : num_scls
    K(:, (i - 1) * n + 1 : i * n) = expm(-L * scls(i));
end
end

