function [  ] = choice_of_m( scales, sCall,fCall )
%UNTITLED2 Summary of this function goes here
%   this function collects means of correlations for some repetitions and
%   uses them to plot correlation dependency on number of scales.
stats = [];
num_samples = 8;
for i = 1 : 10
    smpl = randi(num_samples,1,4);
    stats = [stats,stats_m( sCall(:,:,smpl), fCall(:,:,smpl), scales)];
end

M = mean(stats,2); 
Std_Dev = std(stats,0,2);

errorbar(scales,M,Std_Dev)
xlabel('number of scales, m')
ylabel('average correlation')
title('average correlation vs number of scales, m')
end

