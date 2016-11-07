close all
clear 
clc
%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions, loading all good subjects working with version1.

%% parameters
m = 10;
[~, n, num_subs] = size(sCall);
epsilon = 0.0;

%% scale

exp_values = linspace(0.01, 0.99, m);
[MapC, inds] = pre_process(sCall(:, :, 1), fCall(:, :, 1));
[L, U, lambda] = laplacian(MapC);
t = - log(exp_values) / lambda(round(0.5 * n), 1);

%% plots

plot(lambda, exp(-lambda * t))
axis([min(lambda), max(lambda), 0, 1])
title('choice of scales', 'fontsize', 15), xlabel('\lambda', 'fontsize', 13), ylabel('e^{- \lambda t}', 'fontsize', 13)