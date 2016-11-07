% close all
% clear 
% clc
%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions, loading all good subjects working with version1.

%% parameters
m = 100;
[~, n, num_subjs] = size(sCall);
epsilon = 0.0;
num_scl = 100;
%% scale set
% exp_values = linspace(0.01, 0.99, m);
scl = linspace(0.0001, 12, num_scl);
%{
change this in this script
for 68 regions data scale range is [0.01, 4]
for 188 regions data scale range is [0.01, 12]
%}
%% subject plots
corr_vals = zeros(size(scl, 2), num_subjs);
for subj_idx = 1 : num_subjs
    % pre-processing
    [MapC, inds] = pre_process(sCall(:,:,subj_idx), fCall(:,:,subj_idx));
    
    % thresholding SC
    MapC = (MapC > epsilon * max(MapC(:))) .* MapC;
    
    % laplacian
    [ L, U, lambda ] = laplacian( MapC );
    
%     % scale set
%     t = - log(exp_values) / lambda(round(0.5 * n), 1);
    
    % Pearson correlations
    for scl_idx = 1 : size(scl, 2)
        % diffusion kernels
        K = U * diag(exp(-lambda * scl(scl_idx))) * U';
        c = corrcoef(K .* inds, fCall(:, :, subj_idx) .* inds);
        corr_vals(scl_idx, subj_idx) = c(1, 2);
    end
end
% finding max PC scales
[max_corr, max_scl] = max(corr_vals);
max_scl = ((max(scl) - min(scl)) / (num_scl - 1)) * (max_scl - num_scl) + max(scl);
%% plotting curves
idx = randperm(num_subjs);
f_pc_curves = figure('name', 'PC_curves');
plot(scl, corr_vals(:, idx(1 : 20)))
title({'Pearson correlation curves'; 'linearly spaced scales'}, 'fontsize', 15), xlabel('Scales', 'fontsize', 13), ylabel('Pearson correlation', 'fontsize', 13)

f_hist = figure('name', 'histogram of scales');
hist(max_scl);
xlim([min(scl), max(scl)])
title({'Optimum scale distribution for all subjects'; 'single scale model'}, 'fontsize', 15), xlabel('Scales', 'fontsize', 13), ylabel('# subjects', 'fontsize', 13)

%% saving

save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version1/single_scale_corr_vals_188.mat');
