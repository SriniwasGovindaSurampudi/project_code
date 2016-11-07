function [ ] = num_scales( sCall,fCall )
%UNTITLED2 Summary of this function goes here
%   This function plots correlation for the selected number of scales.

l = cell(1,5);
l{1,1} = 'm = 5';
l{1,2} = 'm = 8';
l{1,3} = 'm = 10';
l{1,4} = 'm = 12';
l{1,5} = 'm = 16';

[result] = MultipleKernels_version2(sCall, fCall, 5);
plot(result{1,2},'bo-')
hold on
[result] = MultipleKernels_version2(sCall, fCall, 8);
plot(result{1,2},'g*:')
[result] = MultipleKernels_version2(sCall, fCall, 10);
plot(result{1,2},'r+-.')
[result] = MultipleKernels_version2(sCall, fCall, 12);
plot(result{1,2},'c*--')
[result] = MultipleKernels_version2(sCall, fCall, 16);
plot(result{1,2},'ms-')
legend(l,'location','best')

ylabel('correlations')
xlabel('samples')
title('correlation values for number of scales, m')
end

