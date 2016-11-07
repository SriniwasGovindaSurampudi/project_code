% close all
% clear
% clc

%% load data
load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
% load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions

%% parameters
% num_scl = 10; % not needed here
[~, n, num_subj] = size(sCall);
epsilon = 0.0;
num_scls = 32;
idx_lam = floor(n / 15);

%% call MKL functions

% randomly shuffle all matrices
random_indices = randperm(num_subj);
% sequentially partition matrices into vaildation and train data

alpha = training_version1(sCall(:, :, random_indices(1 : num_subj / 2)), fCall(:, :, random_indices(1 : num_subj / 2)), num_scls, epsilon, idx_lam);
[ FC_pred, corr ] = testing_version3(sCall(:, :, random_indices(1 : num_subj / 2)), fCall(:, :, random_indices(1 : num_subj / 2)), num_scls, alpha, epsilon, idx_lam);

%% poltting

legend_cell = {};
f_MKL = figure('name', 'MKL');

plot([1 : num_subj / 2], corr, 'r*-');
axis([0, num_subj / 2 + 1, 0 0.45])

%% sc scales fc

sc = sCall(:, :, random_indices(20));
fc = fCall(:, :, random_indices(20));
[ MapC, inds ] = pre_process(sc, fc);
[ K ] = Kernels_version1( MapC, 10, idx_lam );

f_SC_scales_FC = figure('name', 'SC_scales_FC');
subplot(1, 5, 1), imagesc(sc), colormap('jet'), title('Observed SC')
subplot(1, 5, 4), imagesc(reshape(K(:, 3), [n, n])), colormap('jet'), title('Large scale')
subplot(1, 5, 3), imagesc(reshape(K(:, 6), [n, n])), colormap('jet'), title('Medium scale')
subplot(1, 5, 2), imagesc(reshape(K(:, 9), [n, n])), colormap('jet'), title('Small scale')
subplot(1, 5, 5), imagesc(fc), colormap('jet'), title('Observed FC')