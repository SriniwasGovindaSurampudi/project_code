%% comparing single scale with versionIII
%% with 68 roi's
load('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_68_lam_1by40.mat');
cd ../../../project_code/static_SC-FC/ashish_raj_code
Hhat = copyAuthorsCode(sCall(:, :, random_indices(1 : fold)),fCall(:, :, random_indices(1 : fold)));
load('funcStructParameters.mat');
figure('name', 'PC_comp_68')
hold on
plot((1 : fold), corr{1, 1}, 'g*-');
plot((1 : fold), Cor.corCoef, 'ro-');
grid on
title('Pearson correlation comparison, 68 rois')
xlabel('Subjects'), ylabel('Pearson correlation')
legend({'Multiple kernels model', 'Single scale model'})
hold off
print('/Users/govinda/Desktop/Project/reports/paper_drafts/jneurosci/images/PC_comp_68', '-dpng','-r300');
%% with 188 roi's
load('/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_188_lam_1by100.mat');
cd ../../../project_code/static_SC-FC/ashish_raj_code
Hhat = copyAuthorsCode(sCall(:, :, random_indices(1 : fold / 2)),fCall(:, :, random_indices(1 : fold / 2)));
load('funcStructParameters.mat');
figure('name', 'PC_comp_188')
hold on
plot((1 : fold), corr{1, 1}, 'g*-');
plot((1 : fold), Cor.corCoef, 'ro-');
grid on
title('Pearson correlation comparison, 188 rois')
xlabel('Subjects'), ylabel('Pearson correlation')
legend({'Multiple kernels model', 'Single scale model'})
hold off
print('/Users/govinda/Desktop/Project/reports/paper_drafts/jneurosci/images/PC_comp_188', '-dpng','-r300');