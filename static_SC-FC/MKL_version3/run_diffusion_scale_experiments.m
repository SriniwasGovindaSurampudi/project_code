clear
close all
clc
%% data loading
load('/Users/govinda/Desktop/Project/data/dynamic_SC-FC/data_68_ROI/SC_FC_matrices.mat'); % 68 regions
% load('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/sc_fc_selected.mat'); % 188 regions
%% parameters
[~, n, num_subjs] = size(sCall);
num_scls = 8;
idx_lam = ceil(n * 1 / 40);
%% Element-wise variance in SC
m = mean(sCall, 3);
v = var(sCall, 0, 3);
figure('name', 'SC, mean & var')
subplot(1, 2, 1), imagesc(m), colormap('jet'), colorbar, title('mean')
subplot(1, 2, 2), imagesc(v), colormap('jet'), colorbar, title('variance')
%% Diffusion testing
r1 = 11;%randi(num_subjs);
r2 = 45;%randi(num_subjs);
sc1 = sCall(:, :, r1);
sc2 = sCall(:, :, r2);
fc1 = fCall(:, :, r1);
fc2 = fCall(:, :, r2);

% pre-processing
[MapC1, inds1] = pre_process(sc1, fc1);
[MapC2, inds2] = pre_process(sc2, fc2);

% K = Kernels_version3(MapC, num_scls, idx_lam);
[ L1, U1, lambda1 ] = laplacian( MapC1 );
[ L2, U2, lambda2 ] = laplacian( MapC2 );
% scale selection
exp_values = linspace(0.01, 0.95, num_scls);
scls1 = - log(exp_values) / lambda1(round(idx_lam), 1);
scls2 = - log(exp_values) / lambda2(round(idx_lam), 1);
% computing heat kernels, K_{subj_idx, scl_idx}
for i = 3 : 3 % only first scale
    K11 = expm(-L1 * scls1(i));
    K21 = expm(-L2 * scls1(i));
    K12 = expm(-L1 * scls2(i));
    K22 = expm(-L2 * scls2(i));
end
% plotting for comparison
figure('name', 'diffusion scales')
subplot(3, 2, 1),
imagesc(MapC1), title('subj1')
colormap('jet'), colorbar
subplot(3, 2, 2),
imagesc(MapC2), title('subj2')
colormap('jet'), colorbar
subplot(3, 2, 3),
imagesc(K11), title('subj1, scale1')
colormap('jet'), colorbar
subplot(3, 2, 4),
imagesc(K12), title('subj1, scale2')
colormap('jet'), colorbar
subplot(3, 2, 5),
imagesc(K21), title('subj2, scale1')
colormap('jet'), colorbar
subplot(3, 2, 6),
imagesc(K22), title('subj2, scale2')
colormap('jet'), colorbar
