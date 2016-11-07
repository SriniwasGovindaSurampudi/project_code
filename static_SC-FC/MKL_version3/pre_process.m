function [ MapC, inds ] = pre_process( SC,FC )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% SC pre-processing
nzs = nonzeros(SC);
MapC =((SC > 0.01 * std(nzs))) .* SC;
NormMean = mean(nonzeros(MapC));
MapC = MapC/NormMean; % Normalize struct matrix
clear NormMean;

% FC pre-processing
inds = (abs(FC) > 0.1 * max(abs(FC(:))));
%inds(1:n+1:end) = 0;
end

