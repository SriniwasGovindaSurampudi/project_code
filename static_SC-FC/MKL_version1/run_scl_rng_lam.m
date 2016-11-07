% close all
% clear 
% clc
%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions, loading all good subjects working with version1.

%% parameters
m = 10;
[~, n, num_subs] = size(sCall);
epsilon = 0.0;

%% scales per lambda, plots

exp_values = linspace(0.01, 0.99, m);
[MapC, inds] = pre_process(sCall(:, :, 1), fCall(:, :, 1));
[L, U, lambda] = laplacian(MapC);
scales_lam = zeros(n, m);

f_scl_lam = figure('name', 'scales_lambda_variations');
hold on
for idx_lam = 2 : n
    scales_lam(idx_lam, :) = - log(exp_values) / lambda(round(idx_lam), 1);
    plot(scales_lam(idx_lam, :), (idx_lam) * ones(1, m), '.-')
end
hold off
title('Variation of scales with \lambda', 'fontsize', 15), xlabel('Scale', 'fontsize', 13), ylabel('\lambda', 'fontsize', 13)
ylim([1 , n])
xlim([0, max(scales_lam(:))])
grid on

%% saving

save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version1/lambda_variations/scales_lambda_variations_188.mat');