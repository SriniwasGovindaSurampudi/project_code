close all
clear 
clc

load('fC_to_sC_Mtx');

Hhat = copyAuthorsCode(sCall,fCall);

[alpha, corr_outside, ALPHA, corr_ALPHA, H_ALPHA] = Multiple_Kernels_version1(sCall,fCall);

[result] = MultipleKernels_version2(sCall, fCall);

close all

load('funcStructParameters.mat')

d1_PC = figure();
names = cell(1,3);
names{1,1} = 'single scale diffusion';
names{1,2} = 'MKL version1';
names{1,3} = 'MKL version2';

plot(Cor.corCoef, 'ro-')
hold on
plot(corr_ALPHA, 'b*-')
plot(result{1,2}, 'gs-')
hold off

legend(names, 'location','best')
title('Pearson correlation')
xlabel('subject index')
ylabel('Correlation with empirical FC')