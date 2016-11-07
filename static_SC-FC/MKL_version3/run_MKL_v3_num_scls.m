close all
clear
clc
%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/SC_FC_94.mat'); % 188 regions

%% parameters
% num_scl = 10; % not needed here
[~, n, num_subjs] = size(sCall);
epsilon = 0.0;
% space = 25;
idx_lam = ceil(n / 40);
num_folds = 2;
fold = floor(num_subjs / num_folds);
%% calling MKL 
% randomly shuffle all matrices
random_indices = randperm(num_subjs);
train_idx = [1 : (1 - 1) * fold , 1 + (1) * fold : num_folds * fold];
test_idx = 1 + (1 - 1) * fold : (1) * fold;

legend_cell = {};

for num_scls = [2, 4, 8, 16, 32]
    result_numscl{1, num_scls} = Multiple_Kernels_version3(sCall(:, :, random_indices(train_idx)), fCall(:, :, random_indices(train_idx)), num_scls, epsilon, idx_lam);
%     plot(result_numscl{1, num_scls}{1, 2})
    legend_cell = [legend_cell, {['num\_scales = ', num2str(num_scls)]}];
end
%% plotting
f_MKL_num_scl = figure('name', 'number of scales variations');
hold on
for num_scls = [2, 4, 8, 16, 32]
     plot(result_numscl{1, num_scls}{1, 2})
end
hold off
axis([0, num_subjs / 2, 0.5, 1.0])
title({'Pearson correlation'}, 'fontsize', 15), xlabel('Subjects', 'fontsize', 13), ylabel('Pearson correlation', 'fontsize', 13)
legend(legend_cell, 'fontsize', 13);
grid on
%% saving
save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/num_scl_variations/MKL_num_scl_variations_94_lam_1by40.mat');