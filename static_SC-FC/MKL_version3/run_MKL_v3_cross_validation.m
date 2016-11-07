% close all
% clear
clc
%% data loading
% load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions
%% parameters
[~, n, num_subjs] = size(sCall);
epsilon = 0.0;
num_scls = 8;
idx_lam = ceil(n * 1 / 100);
%{
if n == 68, ceil(n / 40) = 2;
and
if n == 188, ceil(n / 100) = 2;

don't want 1.
%}
result_crs_valid = cell(3, 3); % 3 num_folds
for num_folds =  [2, 4, 6]
    fold = floor(num_subjs / num_folds);
    pi = cell(1, num_folds);
    FC_pred = cell(1, num_folds);
    corr = cell(1, num_folds);
    
    %% calling MKL functions per fold
    % randomly shuffle all matrices
    random_indices = randperm(num_subjs);
    
    for i = 1 : num_folds
        % sequentially partition matrices into vaildation and train data
        train_idx = [1 : (i - 1) * fold , 1 + (i) * fold : num_folds * fold];
        test_idx = 1 + (i - 1) * fold : (i) * fold;
        pi{1, i} = training_version3(sCall(:, :, random_indices(train_idx)), fCall(:, :, random_indices(train_idx)), num_scls, epsilon, idx_lam);
        [FC_pred{1, i}, corr{1, i}] = testing_version3(sCall(:, :, random_indices(test_idx)), fCall(:, :, random_indices(test_idx)), num_scls, pi{1, i}, epsilon, idx_lam);
    end
    result_crs_valid{1, num_folds} = pi;
    result_crs_valid{2, num_folds} = FC_pred;
    result_crs_valid{3, num_folds} = corr;
end
%% plotting
for num_folds = [2, 4, 6]
    fold = floor(num_subjs / num_folds);
    
    figure('name', ['PC comp for num_folds = ', num2str(num_folds)])
    legend_cell = {};
    hold on
    for i = 1 : num_folds
        plot(1 : fold, result_crs_valid{3, num_folds}{1, i})
        legend_cell = [legend_cell, ['fold ', num2str(i)]];
    end
    hold off
    axis([0, fold + 1, 0, 1])
    title('Pearson correlation for test subjects')
    xlabel('Test Subjects')
    ylabel('Pearson correlation')
    legend(legend_cell)
    grid on
    
    figure('name', ['\pi comp within ', num2str(num_folds), 'folds']);
    for i = 1 : num_folds
        for j = 1 : num_scls
            subplot(num_folds, num_scls, j + (i - 1) * num_scls); 
            imagesc(result_crs_valid{1, num_folds}{1, i}(1 + (j - 1) * n : (j) * n, :)); 
            colormap('jet'); colorbar;
            title(['scale\_index = ', num2str(i)]);
        end
    end
end
%% variance of \pi across folds
avg_pi = cell(1, 3);
for num_folds = [2, 4, 6]
    avg_pi{1, num_folds} = zeros(n * num_scls, n);
    for i = 1 : num_folds
        avg_pi{1, num_folds} = avg_pi{1, num_folds} + result_crs_valid{1, num_folds}{1, i};
    end
    avg_pi{1, num_folds} = avg_pi{1, num_folds} / num_folds;
    pi_var{1, num_folds} = zeros(1, num_folds);
    for i = 1 : num_folds
        pi_var{1, num_folds}(1, i) = sqrt(sum(sum((avg_pi{1, num_folds} - result_crs_valid{1, num_folds}{1, i}).^2))) / (n * n);
    end
end
%% saving
save('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_188_lam_1by100.mat')