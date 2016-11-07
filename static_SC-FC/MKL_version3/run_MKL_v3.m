close all
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
%% MKL calling MKL functions
pi = cell(1, num_folds);
FC_pred = cell(1, num_folds);
corr = cell(1, num_folds);

% randomly shuffle all matrices
random_indices = randperm(num_subjs);

legend_cell = {};
for i = 1 : num_folds
    % sequentially partition matrices into vaildation and train data
    train_idx = [1 : (i - 1) * fold , 1 + (i) * fold : num_folds * fold];
    test_idx = 1 + (i - 1) * fold : (i) * fold;
    pi{1, i} = training_version3(sCall(:, :, random_indices(train_idx)), fCall(:, :, random_indices(train_idx)), num_scls, epsilon, idx_lam);
    [FC_pred{1, i}, corr{1, i}] = testing_version3(sCall(:, :, random_indices(test_idx)), fCall(:, :, random_indices(test_idx)), num_scls, pi{1, i}, epsilon, idx_lam);
    legend_cell = [legend_cell, ['fold ', num2str(i)]];
end
%% plotting
f_MKL_v3 = figure('name', 'MKL_v3_3by4');
hold on
plot(1 : fold, corr{1, 1}, 'b*-')
plot(1 : fold, corr{1, 2}, 'ro-')
hold off
axis([0, fold + 1, 0, 1])
title('Pearson correlation for test subjects')
xlabel('Test Subjects')
ylabel('Pearson correlation')
legend(legend_cell)
grid on

f_pi = figure('name', '');
subplot(1, 2, 1), imagesc(pi{1, 1})
colormap('jet'), colorbar
title('\pi for fold 1')
subplot(1, 2, 2), imagesc(pi{1, 2})
colormap('jet'), colorbar
title('\pi for fold 2')

%% saving
save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_94_lam_1by40.mat')