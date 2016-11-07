function [ K ] = Kernels_version1( W, num_scl, idx_lam )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% variables
n = size(W,1);
K = zeros(n * n, num_scl);

% normalized laplacian, eigen decompsition
[ L, U, lambda ] = laplacian( W );

% scale selection
exp_values = linspace(0.01, 0.9, num_scl);
t = - log(exp_values) / lambda(round(idx_lam), 1);

% computing heat kernels
for i = 1 : num_scl
    K(:, i) = reshape(expm(-L * t(i)), [n * n , 1]);
end

end

