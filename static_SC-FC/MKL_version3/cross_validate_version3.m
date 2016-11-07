function [ cv_result ] = cross_validate_version3( sCall, fCall, folds, m, epsilon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% variables
[~, ~, L] = size(sCall);
index = randperm(L);
sCall(:,:,:) = sCall(:,:,index);
fCall(:,:,:) = fCall(:,:,index);

t = L / folds; % number of test samples, assuming t as interger.
start_idx = 0 : t : (folds-1)*t;
end_idx = start_idx + t;

cv_result = cell(3, folds);
% cv_result{1,:} = pi;
% cv_result{2,:} = pred_FC;
% cv_result{3,:} = corr;

% validate per fold
for i = 1 : folds
    % training
    cv_result{1, i} = training_version3(sCall(:, :, [1 : start_idx(i), end_idx(i) + 1 : L]),...
                                       fCall(:, :, [1 : start_idx(i), end_idx(i) + 1 : L]), m, epsilon);
    % testing
    [cv_result{2, i}, cv_result{3, i}] = testing_version3(sCall(:, :, [start_idx(i) + 1 : end_idx(i)]),...
                                      fCall(:, :, [start_idx(i) + 1 : end_idx(i)]),...
                                      m, cv_result{1,i}, epsilon);
end
end

