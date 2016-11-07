%{
this code randomly collects num_samples number of samples from the new data
containing time series as well
%}
close all
clear 
list = dir(strcat('./','SC_FC_all_new'));

sample_num = randperm((size(list,1)-2)/2) + 1;
num_samples = 16;
sCall = zeros(68,68,num_samples);
fCall = zeros(68,68,num_samples);

name = './SC_FC_all_new/';

for i = 1 : num_samples
    load(strcat(name,list(sample_num(i)*2-1).name));
    load(strcat(name,list(sample_num(i)*2).name));
    fCall(:,:,i) = FC_cc(1:68,1:68);
    sCall(:,:,i) = SC_cap_agg_bwflav2_norm;
end