function [result] = main_version2()
clear
close all
load('/Users/govinda/Desktop/spring2016/Original Authors code/fC_to_sC_Mtx.mat');
result = MultipleKernels_version2(sCall, fCall);
figure
plot(result{1,2})
grid on
end