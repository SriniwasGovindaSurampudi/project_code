close all
clear 
clc

%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions

%% parameters
% num_scl = 10; % not needed here 
[~, n, num_subj] = size(sCall);
epsilon = 0.0;
num_scls = 10;
idx_lam = n / 2;
num_folds = 4; 
%{
num_folds = 7 for 68 regions
num_folds = 4 for 188 regions
%}
fold = num_subj / num_folds;
result_cv = cell(3, num_folds);

%% cross-validation

% randomly shuffle all matrices
random_indices = randperm(num_subj);
% sequentially partition matrices into vaildation and train data
legend_cell = {};
f_cross_valid = figure('name', 'cross_validation');
hold on
for i = 1 : num_folds
    start = 1 + (i - 1) * fold;
    finish = (i) * fold;
    idx_train = [1 : start - 1, finish + 1 : num_subj];
    idx_vaild = start : finish;
    alpha = training_version1(sCall(:, :, random_indices(idx_train)), fCall(:, :, random_indices(idx_train)), num_scls, epsilon, idx_lam);
    [ FC_pred, corr ] = testing_version3(sCall(:, :, random_indices(idx_vaild)), fCall(:, :, random_indices(idx_vaild)), num_scls, alpha, epsilon, idx_lam);
    result_cv{1, i} = alpha;
    result_cv{2, i} = corr;
    result_cv{3, i} = FC_pred;
    plot((1 : fold), result_cv{2, i});
    legend_cell = [legend_cell, {['fold number = ', num2str(i)]}];
end
hold off
axis([0, fold + 1, 0, 0.7])
title({'Pearson correlation for each fold'}, 'fontsize', 15), xlabel('Subjects per fold', 'fontsize', 13), ylabel('Pearson correlation', 'fontsize', 13)
legend(legend_cell, 'fontsize', 15);
grid on
%% saving

save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version1/cross_validation/MKL_cross_validation_188.mat');






















