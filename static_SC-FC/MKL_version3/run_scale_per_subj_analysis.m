% close all
clear
clc
%% data loading
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/SC_FC_94.mat'); % 94 regions
%% parameters
[~, n, num_subjs] = size(sCall);
epsilon = 0.0;
num_scls = 8;
idx_lam = ceil(n * 1 / 40);
%{
if n == 68, ceil(n / 40) = 2;
and
if n == 188, ceil(n / 100) = 2;

don't want 1.
%}
num_folds = 2;
fold = floor(num_subjs / num_folds);
subj_scl_mat = cell(1, num_folds);
K_mat = cell(1, num_folds);
Lam_idx = cell(1, num_folds);
random_indices = randperm(num_subjs);
%% computing scale set \tau for every test subject
for fold_idx = 1 : num_folds
    test_idx = 1 + (fold_idx - 1) * fold : (fold_idx) * fold;
    subj_scl_mat{1, fold_idx} = zeros(fold, num_scls);
    K_mat{1, fold_idx} = cell(1, fold);
    Lam_mat{1, fold_idx} = cell(1, fold);
    for sub_idx = 1 : fold
        % pre-processing
        [MapC, inds] = pre_process(sCall(:, :, random_indices(test_idx(sub_idx))), fCall(:, :, random_indices(test_idx(sub_idx))));
        % K = Kernels_version3(MapC, num_scls, idx_lam);
        [ L, U, lambda ] = laplacian( MapC );
        % scale selection
        exp_values = linspace(0.01, 0.95, num_scls);
        scls = - log(exp_values) / lambda(round(idx_lam), 1);
        % computing heat kernels
        K_mat{1, fold_idx}{1, sub_idx} = zeros(n, n, num_scls);
        Lam_mat{1, fold_idx}{1, sub_idx} = zeros(n, 1);
        K = zeros(n, n, num_scls);
        for scl_idx = 1 : num_scls
            K(:, :, scl_idx) = expm(-L * scls(scl_idx));
        end
        Lam_mat{1, fold_idx}{1, sub_idx} = lambda;
        K_mat{1, fold_idx}{1, sub_idx} = K;
        subj_scl_mat{1, fold_idx}(sub_idx, :) = scls;
    end
end