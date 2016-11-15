%% comparison b/w single scale with versionIII
%% with 68 roi's
load('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_68_lam_1by40.mat');
cd ../ashish_raj_code
Hhat = copyAuthorsCode(sCall(:, :, random_indices(1 : fold)),fCall(:, :, random_indices(1 : fold)));
load('funcStructParameters.mat');

% PC-------------------------
f_pc_68 = figure('name', 'PC_comp_68');
hold on
plot((1 : fold), corr{1, 1}, 'g*-');
plot((1 : fold), Cor.corCoef, 'ro-');
grid on
title('Pearson correlation comparison, 68 rois')
xlabel('Subjects'), ylabel('Pearson correlation')
legend({'Multiple kernels model', 'Single scale model'})
hold off

f_pc_68;
print('/Users/govinda/Desktop/Project/reports/paper_drafts/jneurosci/images/PC_comp_68', '-dpng','-r300');
%---------------------------

% MSE ----------------------
m_s_e_mkl_68 = zeros(1, fold);
m_s_e_ss_68  = zeros(1, fold);
for i = 1 : fold
    m_s_e_mkl_68(1, i) = sqrt(sum(sum((fCall(:, :, random_indices(i)) - FC_pred{1, 1}(:, :, i)).^2))) / (n * n);
    m_s_e_ss_68(1, i)  = sqrt(sum(sum((fCall(:, :, random_indices(i)) - Hhat{i})))) / (n * n);
end
f_mse_68 = figure('name', 'MSE_comp_68');
hold on
plot((1 : fold), m_s_e_mkl_68, 'g*-')
plot((1 : fold), m_s_e_ss_68,  'ro-')
grid on
title('Mean squared error comparison, 68 rois')
xlabel('Subjects'), ylabel('Mean squared error')
legend({'Multiple kernels model', 'Single scale model'})
hold off

f_mse_68;
print('/Users/govinda/Desktop/Project/reports/paper_drafts/jneurosci/images/MSE_comp_68', '-dpng','-r300');
%---------------------------
%% 
cd ../MKL_version3
%% with 188 roi's
load('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_188_lam_1by100.mat');
cd ../../../project_code/static_SC-FC/ashish_raj_code
Hhat = copyAuthorsCode(sCall(:, :, random_indices(1 : fold / 2)),fCall(:, :, random_indices(1 : fold / 2)));
load('funcStructParameters.mat');

% PC------------------------
f_pc_188 = figure('name', 'PC_comp_188');
hold on
plot((1 : fold / 2), corr{1, 1}(1 : fold / 2), 'g*-');
plot((1 : fold / 2), Cor.corCoef, 'ro-');
grid on
title('Pearson correlation comparison, 188 rois')
xlabel('Subjects'), ylabel('Pearson correlation')
legend({'Multiple kernels model', 'Single scale model'})
hold off

f_pc_188;
print('/Users/govinda/Desktop/Project/reports/paper_drafts/jneurosci/images/PC_comp_188', '-dpng','-r300');
%--------------------------

% MSE----------------------
m_s_e_mkl_68 = zeros(1, fold / 2);
m_s_e_ss_68  = zeros(1, fold / 2);
for i = 1 : size(m_s_e_mkl_68, 2)
    m_s_e_mkl_68(1, i) = sqrt(sum(sum((fCall(:, :, random_indices(i)) - FC_pred{1, 1}(:, :, i)).^2))) / (n * n);
    m_s_e_ss_68(1, i)  = sqrt(sum(sum((fCall(:, :, random_indices(i)) - Hhat{i})))) / (n * n);
end
f_mse_188 = figure('name', 'MSE_comp_68');
hold on
plot((1 : size(m_s_e_mkl_68, 2)), m_s_e_mkl_68, 'g*-')
plot((1 : size(m_s_e_mkl_68, 2)), m_s_e_ss_68,  'ro-')
grid on
title('Mean squared error comparison, 188 rois')
xlabel('Subjects'), ylabel('Mean squared error')
legend({'Multiple kernels model', 'Single scale model'})
hold off

f_mse_188;
print('/Users/govinda/Desktop/Project/reports/paper_drafts/jneurosci/images/MSE_comp_188', '-dpng','-r300');
%--------------------------