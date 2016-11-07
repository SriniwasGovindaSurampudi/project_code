function [ CC200_labels, CC200_centerOfMass ] = extract_CC200( pth )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% load the labels file
CC200_labels = readtable([pth, 'CC200_ROI_labels.csv']);
% collect center of masses into a matrix
[num_rois, ~] = size(CC200_labels);
CC200_centerOfMass = zeros(num_rois, 3);
for i = 1 : num_rois
    CC200_centerOfMass(i, :) = str2num(CC200_labels.centerOfMass{i}(2 : end - 1));
end
end

