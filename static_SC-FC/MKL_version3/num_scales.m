function [ corr_mean_per_scale, corr_std_per_scale ] = num_scales( sCall, fCall, scales, epsilon )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% variables
[~, ~, L] = size(sCall);
folds = 5;
corr = zeros(folds, L / folds);
corr_mean_per_scale = zeros(size(scales));
corr_std_per_scale = zeros(size(scales));

% validation
for sc = scales
    cv_result = cross_validate_version3(sCall, fCall, folds, sc, epsilon);
    for i = 1 : folds
        corr(i, :) = cv_result{3,i};
    end
    corr_mean_per_scale(1, sc) = mean(corr(:));
    corr_std_per_scale(1, sc) = std(corr(:));
end
end