function [ fc, corr_bases, fig_name ] = bases_FC( SC, FC, result, m )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fig_name = figure('name', 'normalized');
fc = cell(1, m);
corr_bases = zeros(1, m);
exp_values = linspace(0.05, 0.95, m);
[MapC, ~] = pre_process(SC, FC);
K = Kernels_version3(MapC,m);
for i = 1 : m
fc{1, i} = K(:, (i - 1) * 68 + 1 : i * 68) * result{1, 1}(1 + (i - 1) * 68 : i * 68, :);
fc{1, i} = (fc{1, i} + fc{1, i}') / 2;
c = corrcoef(FC, fc{1, i});
corr_bases(1, i) = c(1, 2);
subplot(3, 4, i)
colormap('jet')
imagesc(fc{1, i}), title(sprintf('scale ≈ %0.2f, corr = %d', exp_values(1, i), corr_bases(1, i)))
caxis([0, 1]), colorbar
end
subplot(3, 4, 11), colormap('jet'), imagesc(SC), title('SC'), caxis([0, 1]), colorbar
subplot(3, 4, 12), colormap('jet'), imagesc(FC), title('FC'), caxis([0, 1]), colorbar
end

