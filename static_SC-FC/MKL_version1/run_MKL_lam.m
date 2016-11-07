% close all
% clear 
% clc
%% load data
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions

%% parameters
m = 10; 
[~, n, num_subj] = size(sCall);
epsilon = 0.0;
space = 35;
%% call MKL functions
%{
alpha = training_version1(sCall, fCall, m, epsilon, round(n/2));
[ FC_pred, corr ] = testing_version3(sCall, fCall, m, alpha, epsilon, round(n/2));
result{1, 1} = alpha;
result{1, 2} = corr;
result{1, 3} = FC_pred;
%}

for idx_lam = 1 : space : n
    result_lam{1, idx_lam} = Multiple_Kernels_version1(sCall, fCall, m, epsilon, idx_lam);
end

%% plotting PC for each idx_lam
legend_cell = {};
f_pc_MKL_lam = figure('name', 'MKL_lambda_variations');
hold on
config = 1;
for idx_lam = 1 : space : n
    plot(result_lam{1, idx_lam}{1, 2})
    legend_cell = [legend_cell, {['\tau = ', num2str(config)]}];
    config = config + 1;
end
hold off
axis([0, num_subj / 2  , 0.15, 0.45])
title({'Pearson correlation for all subjects'}, 'fontsize', 15), xlabel('Subjects', 'fontsize', 13), ylabel('Pearson correlation', 'fontsize', 13)
legend(legend_cell, 'fontsize', 15);
grid on

f_alpha_lam = figure('name', 'alpha_lambda_variations');
hold on
for idx_lam = 1 : space : n
    plot(result_lam{1, idx_lam}{1, 1})
end
hold off
title({'\alpha for all lambda choices'; 'one plot for one \lambda'}, 'fontsize', 15), xlabel('\alpha components', 'fontsize', 13), ylabel('\alpha value', 'fontsize', 13)
legend(legend_cell, 'fontsize', 15);
grid on

%% saving

save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version1/lambda_variations/MKL_lambda_variations_188.mat');