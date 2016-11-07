clear
close all
%% data
%{
this code randomly collects num_samples number of samples from the new data
containing time series as well
%}
list = dir(strcat('./','SC_FC_all_new'));

%sample_num = randperm((size(list, 1) - 3) / 2) + 1;
sample_num = 2 : 50;
num_samples = 49;
sCall = zeros(68,68,num_samples);
fCall = zeros(68,68,num_samples);

name = './SC_FC_all_new/';

for i = 1 : num_samples
    load(strcat(name,list(sample_num(i)*2).name));
    load(strcat(name,list(sample_num(i)*2 + 1).name));
    fCall(:,:,i) = FC_cc(1:68,1:68);
    sCall(:,:,i) = SC_cap_agg_bwflav1_norm;
end

%{
%% author's code
Hhat = copyAuthorsCode(sCall,fCall);
load funcStructParameters.mat
%% MKL version1
Multiple_Kernels

%% MKL version2
[result] = MultipleKernels_version2(sCall, fCall);

%% plotting

figure,
plot(Cor.corCoef)
hold on
plot(corr_ALPHA)
plot(result{1,2})
hold off
grid on

for i = 1 : num_samples
figure, imagesc(fCall(:,:,i))
end
%}