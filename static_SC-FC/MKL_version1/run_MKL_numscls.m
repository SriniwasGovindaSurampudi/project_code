% close all
% clear 
% clc
%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions

%% parameters
% num_scl = 10; % not needed here 
[~, n, num_subj] = size(sCall);
epsilon = 0.0;
% space = 25;
idx_lam = floor(n/2);
%% calling MKL and plotting
legend_cell = {};
f_MKL_num_scl = figure('name', 'number of scales variations');
hold on
for num_scls = [2, 4, 8, 16, 32]
    result_numscl{1, num_scls} = Multiple_Kernels_version1(sCall, fCall, num_scls, epsilon, idx_lam);
    plot(result_numscl{1, num_scls}{1, 2})
    legend_cell = [legend_cell, {['m = ', num2str(num_scls)]}];
end
hold off
axis([0, num_subj / 2, 0.15, 0.45])
title({'Pearson correlation'}, 'fontsize', 15), xlabel('Subjects', 'fontsize', 13), ylabel('Pearson correlation', 'fontsize', 13)
legend(legend_cell, 'fontsize', 13);

%% saving

save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version1/num_scl_variations/MKL_num_scl_variations_188.mat');