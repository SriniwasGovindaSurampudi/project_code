function [ results ] = age_study( sCall, fCall, m, epsilon, num_samples, block_size, stride )
%UNTITLED Summary of this function goes here
%   this function divides the agewise arranges SC-FC pairs into windows and
%   finds \pi's to study how \pi's change through age.

%{
% m = 10; epsilon = 0.0; num_samples = 49; block_size = 7; stride = 3;
num_windows = (num_samples - block_size) / stride;
results = cell(1, num_windows);
for i = 1 : num_windows
limits = (1 + i * stride) : (1 + i * stride) + (block_size - 1);
[ results{1, i} ] = Multiple_Kernels_version3(sCall(:, :, limits), fCall(:, :, limits), m, epsilon);
end
%}
% %{

%}
end

