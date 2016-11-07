run_MKL
run_corr_vals

f1 = figure('name', 'PC_MKL_max_corr');
hold on
plot((1 : num_subj / 2), corr, 'r*-');
plot(max_corr(random_indices(1 : num_subj / 2)), 'b.-');

f2 = figure('name', 'PC_MKL_corr_vals');
hold on
plot((1 : num_subj / 2), corr, 'r*-');
plot(corr_vals(45, random_indices(1 : num_subj / 2)), 'b.-');
