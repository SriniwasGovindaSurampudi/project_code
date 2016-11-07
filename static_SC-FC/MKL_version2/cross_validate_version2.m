function [ cross_validation_result ] = cross_validate_version2( sCall, fCall, folds, m )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% [cross_validation_result{1,i}] contains output of
% MultipleKernels_version2, first cell of this set contains \alpha's for
% testing.
% [cross_validation_result{2,1}] is the matrix of correlations on test
% samples for each fold.

[~,~,L] = size(sCall);
index = randperm(L);
sCall(:,:,:) = sCall(:,:,index);
fCall(:,:,:) = fCall(:,:,index);

t = L / folds; % number of test samples, assuming t as interger.
start_idx = 0 : t : (folds-1)*t;
end_idx = start_idx + t;

for i = 1 : folds
    % training ================================
    [cross_validation_result{1,i}] = MultipleKernels_version2(sCall(:,:,[1:start_idx(i), end_idx(i)+1:L]),...
                                                              fCall(:,:,[1:start_idx(i), end_idx(i)+1:L]), m);
    % testing =================================
    % correlation values for all samples per fold
    [cross_validation_result{2,1}(i,:),~] = testing(sCall(:,:,[start_idx(i)+1:end_idx(i)]), fCall(:,:,[start_idx(i)+1:end_idx(i)]),...
                                             m, cross_validation_result{1,i}{1,1});
    %[cross_validation_result{3,1}(1,i)] = sum(cross_validation_result{2,1}(i,:))/t; % average testing correlation for each fold
end
%[cross_validation_result{3,2}] = sum(cross_validation_result{3,1})/folds; % overall testing correlation
end

