function [ m_variations, fig_pi_at_m ] = num_scales_experiment( sCall, fCall, epsilon )
%UNTITLED Summary of this function goes here
%   this is for one lambda. Repeat this

m_variations = cell(9, 7);

% store all the training results
for m = 5 : 13
    for i = 1 : 5
        idx = randperm(size(sCall, 3));
        result = Multiple_Kernels_version3(sCall(:, :, idx(1 : 20)), fCall(:, :, idx(1 : 20)), m, epsilon);
        m_variations{m - 4, i} = result;
    end
end

% store mean PC for each number of scale
for m = 5 : 13
    for i = 1 : 5
        m_variations{m - 4, 6} = [m_variations{m - 4, 6}, m_variations{m - 4, i}{1, 2}'];
    end
    m_variations{m - 4, 6} = mean(m_variations{m - 4, 6}, 2);
end

% plot and store mean PC for all scales
l = cell(1, 9); 
for i = 1 : 9
    l{1, i} = ['m = ', num2str(i + 4)];
end
figure,
for m = 5 : 13
    plot(m_variations{m -4, 6})
    hold on
end
axis([0 21 0 1])
legend(l)

% plot and store pi's
fig_pi_at_m = cell(1, 13);
for m = 5 : 13
    fig_pi_at_m{1, m - 4} = figure('name', ['m = ', num2str(m)]);
    for i = 1 : 5
        subplot(1, 5, i)
        imagesc(m_variations{m - 4, i}{1, 1})
        colormap('jet')
    end
end
end

