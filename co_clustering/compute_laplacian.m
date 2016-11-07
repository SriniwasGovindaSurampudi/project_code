function [ L ] = compute_laplacian( W )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
D = diag(sum(W));
d = diag(D);
a = d.^(-0.5);
a(isinf(a)) = 0;
L = diag(a)*(D - W)*diag(a);
end

