close all
clear
clc
%% data loading
load('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_68_lam_1by40.mat'); % 68 regions
% load('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_188_lam_1by100.mat'); % 188 regions
sc_avg = mean(sCall, 3);
fc_avg = mean(fCall, 3);
%% randomizing sc_avg
num_random = 50;
sc_avg_random = zeros(n, n, num_random);
fc_avg_random = zeros(n, n, num_random);
for rand_idx = 1 : num_random
    row_order = randperm(n);
    col_order = randperm(n);
    sc_avg_random(:, :, rand_idx) = sc_avg(row_order, col_order);
    fc_avg_random(:, :, rand_idx) = sc_avg(row_order, col_order);
end
%% saving
save('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/randomized matrices', 'sc_avg_random', 'fc_avg_random');
%% histogram
fc_avg_more = repmat(fc_avg, [1, 1, num_random]);
[FC_pred_random, corr_random] = testing_version3(sc_avg_random, fc_avg_random, num_scls, pi{1, 1}, epsilon, idx_lam); % any pi{1, i} can be given
corr_random = abs(corr_random);

[FC_pred_avg, corr_avg] = testing_version3(sc_avg, fc_avg, num_scls, pi{1, 1}, epsilon, idx_lam); % any pi{1, i} can be given

f_hist_random = figure('name', 'hist_random');
hist([corr_random, corr_avg], 51);