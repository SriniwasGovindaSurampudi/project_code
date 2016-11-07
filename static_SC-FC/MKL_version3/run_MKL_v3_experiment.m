% this code observes the components of every K_{i} * \pi_{i}.
close all
clear
clc
%% data
lam_num = 40;
load(['/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/MKL_cross_validation_94_lam_1by', num2str(lam_num), '.mat']);
%% initializations
%{
look in random_indices to decide on the subject,
hence fix idx(1, 2, 3).
%}
pi_indep = cell(1, 5);
for sub = (5 : 10 : 45)
    % identifying idx(1, 2, 3)
    idx1 = sub;
    id = find(random_indices == sub);
    idx2 = mod(id, fold);
    idx3 = ceil(id / fold);
    
    sc_e = sCall(:, :, idx1);
    fc_e = fCall(:, :, idx1);
    fc_p = FC_pred{1, idx3}(:, :, idx2);
    p = pi{1, idx3};
    [~, n, num_subjs] = size(sCall);
    %% pre-processing
    corr_Kpi_fce = zeros(1, num_scls);
    corr_Kpi_sce = zeros(1, num_scls);
    corr_K_fce = zeros(1, num_scls);
    corr_K_sce = zeros(1, num_scls);
    corr_pi_fce = zeros(1, num_scls);
    corr_pi_sce = zeros(1, num_scls);
    K_pi = zeros(n, n, num_scls);
    
    % pre-processing
    [MapC, inds] = pre_process(sc_e, fc_e);
    
    % K = Kernels_version3(MapC, num_scls, idx_lam);
    [ L, U, lambda ] = laplacian( MapC );
    % scale selection
    exp_values = linspace(0.01, 0.95, num_scls);
    scls = - log(exp_values) / lambda(round(idx_lam), 1);
    % computing heat kernels
    for i = 1 : num_scls
        K(:, (i - 1) * n + 1 : i * n) = expm(-L * scls(i));
    end
    pi_indep{1, (sub + 5) / 10 } = zeros(n, n, num_scls);
    % combining kernels with pi
    for i = 1 : num_scls
        K_pi(:, :, i) = K(:, 1 + (i - 1) * n : (i) * n) * p(1 + (i - 1) * n : (i) * n, :);
        K_pi(:, :, i) = (K_pi(:, :, i) + K_pi(:, :, i)') /2;
        % K_pi vs FC_emp correlation
        c = corrcoef(K_pi(:, :, i), fc_e);
        corr_Kpi_fce(1, i) = c(1, 2);
        c = corrcoef(K(:, 1 + (i - 1) * n : (i) * n), fc_e);
        corr_K_fce(1, i) = c(1, 2);
        c = corrcoef(p(1 + (i - 1) * n : (i) * n, :), fc_e);
        corr_pi_fce(1, i) = c(1, 2);
        % K_pi vs SC_emp correlation
        c = corrcoef(K_pi(:, :, i), sc_e);
        corr_Kpi_sce(1, i) = c(1, 2);
        c = corrcoef(K(:, 1 + (i - 1) * n : (i) * n), sc_e);
        corr_K_sce(1, i) = c(1, 2);
        c = corrcoef(p(1 + (i - 1) * n : (i) * n, :), sc_e);
        corr_pi_sce(1, i) = c(1, 2);
        % independently find \pi for each scale
        pi_indep{1, (sub + 5) / 10}(:, :, i) = K(:, 1 + (i - 1) * n : (i) * n) \ fc_e;
    end
    
    %% plotting
    %{
    f_K_pi = figure('name', ['K_pi_1by40, ', num2str(idx1)]);
    for i = 1 : num_scls
        subplot(2, 5, i),
        imagesc(K_pi(:, :, i)),
        colormap('jet'), colorbar
        title(['scale ', num2str(scls(i))])
    end
    subplot(2, 5, num_scls + 1),
    imagesc(fc_p),
    colormap('jet'), colorbar
    title('FC pred')
    subplot(2, 5, num_scls + 2),
    imagesc(fc_e),
    colormap('jet'), colorbar
    title('FC emp')
    %}
    
    % subject specific correlations
    f_corr = figure('name', ['Kpi_corr, ', num2str(idx1)]);
    % fce vs ...
    subplot(1, 2, 1)
    hold on
    plot(scls, corr_Kpi_fce, 'g*-')
    plot(scls, corr_K_fce, 'bd-')
    plot(scls, corr_pi_fce, 'ro-')
    hold off
    grid on
    legend({'K\pi\_fce', 'K\_fce', '\pi\_fce'})
    title('PC for a subject with FC_{emp}')
    xlabel('scale'); ylabel('Pearson correlation');
    % sce vs ...
    subplot(1, 2, 2)
    hold on
    plot(scls, corr_Kpi_sce, 'g*-')
    plot(scls, corr_K_sce, 'bd-')
    plot(scls, corr_pi_sce, 'ro-')
    hold off
    grid on
    legend({'Kpi\_sce', 'K\_sce', '\pi\_sce'})
    title('PC for a subject with SC_{emp}')
    xlabel('scale'); ylabel('Pearson correlation');
    % axis([0, num_scls + 1, 0, 1])
    pth = ['/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3/Kpi_fce_sce_corr/94_rois/lam_1by', num2str(lam_num), '/'];
    print([pth, 'MKL_v3_Kpi_fce_corr, ', num2str(idx1)] ,'-dpng','-r300');
end
%% correlation between \pi's 
% in folds
p1 = zeros(n, n, num_scls);
p2 = zeros(n, n, num_scls);
corr_p1_p2 = zeros(1, num_scls);
for i = 1 : num_scls
    p1(:, :, i) = pi{1, 1}(1 + (i - 1) * n : (i) * n, :);
    p2(:, :, i) = pi{1, 2}(1 + (i - 1) * n : (i) * n, :);
    c = corrcoef(p1(:, :, i), p2(:, :, 2));
    corr_p1_p2(1, i) = c(1, 2);
end

f_pi_corr = figure('name', 'pi_corr');
plot(corr_p1_p2, 'g*-');
title('Pearson correlation between \pi for each fold')
xlabel({'scale index';'lerge to small'}); ylabel('Pearson correlation');
grid on
print([pth, 'MKL_v3_p1_p2_corr'] ,'-dpng','-r300');

% pi_indep vs pi_fold
f1= figure('name', 'pi\_indep vs pi\_fold');
for i = 1 : num_scls
    subplot(2, num_scls, i), 
    imagesc(pi{1, 1}(1 + (i - 1) * n : (i) * n, :)),
    colormap('jet'), colorbar
    title(['\pi_{1}', num2str(i)])
    subplot(2, num_scls, i + num_scls), 
    imagesc(pi_indep{1, 1}(:, :, i)),
    colormap('jet'), colorbar
    title(['\pi_{1, indep}', num2str(i)])
end
f2= figure('name', 'pi\_indep vs pi\_fold');
for i = 1 : num_scls
    subplot(2, num_scls, i), 
    imagesc(pi{1, 2}(1 + (i - 1) * n : (i) * n, :)),
    colormap('jet'), colorbar
    title(['\pi_{2}', num2str(i)])
    subplot(2, num_scls, i + num_scls), 
    imagesc(pi_indep{1, 1}(:, :, i)),
    colormap('jet'), colorbar
    title(['\pi_{2, indep}', num2str(i)])
end
%% average pi across folds then PC forall subjects
pi_avg = (pi{1, 1} + pi{1, 2}) / 2;
[FC_avg_pred, corr_avg] = testing_version3( sCall(:, :, random_indices), fCall(:, :, random_indices), num_scls, pi_avg, epsilon, idx_lam); 
f_corr_avg = figure('name', 'corr_avg');
hold on
plot(corr_avg, 'g*-')
plot(1 : 2 * fold, [corr{1, 1}, corr{1, 2}], 'ro-')
hold off
legend({'\pi_{avg}', '\pi for each fold'})
title({'Pearson correlation for all subjects';'average \pi across folds'})
xlabel('Subjects'); ylabel('Pearson correlation');
grid on
axis([0, num_subjs + 1, 0, 1])
pth = '/Users/govinda/Desktop/Project/results/static SC-FC/MKL_version3';
