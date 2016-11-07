function [ stats ] = stats_m( sCall, fCall, scales )
%UNTITLED Summary of this function goes here
%   This function outputs the collection of means of correlation per m. 
stats = [];
for scl = scales
    [result] = MultipleKernels_version2(sCall, fCall, scl);
    stats = [stats;mean(result{1,2})];
end

end

