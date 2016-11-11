function [ sCall, fCall, data_names, ages, subj_com ] = Collect_NKI_Rockland_Data( pth )
%COLLECT_NKI_ROCKLAND_DATA Summary of this function goes here
% usage:
% [ all_Emp_SC,all_Emp_FC,data_names ] = Collect_NKI_Rockland_Data( path )
% Collecting NKI_Rockland dataset
% path : (input) main folder path; (default) '/Users/govinda/Desktop/spring2016'
% all_Emp_SC : (output) all subjects' SC matrices in 3d matrix
% all_Emp_FC : (output) all subjects' FC matrices in 3d matrix
% data_names : (output) cell containig names of files belonging to every
% subject
%**************************************************************************
%the cell array data_names contains one subject in a column in the order 
% 1. DTI_connectivity_matrix_file
% 2. DTI_region_names_abbrev_file
% 3. DTI_region_names_full_file
% 4. DTI_region_xyz_centers_file
% 5. fcMRI_*GSR_connectivity_matrix_file
% 6. fcMRI_*GSR_region_names_abbrev_file
% 7. fcMRI_*GSR_region_names_full_file
% 8. fcMRI_*GSR_region_xyz_centers_file
% sample : subject number
% path : 
%**************************************************************************
% addpath(genpath(path))
data_names = cell(8,197);
% num_rois
num_rois = 188;
% SC - FC matrices
sCall = zeros(num_rois,num_rois,size(data_names,2));
fCall = zeros(num_rois,num_rois,size(data_names,2));
% center of masses
subj_com = zeros(num_rois, 3, size(data_names, 2));

data = dir(pth);

for subj_idx = 0 : 196
    % organize all subject specific file names
    for j = 1 : 8
        data_names{j,subj_idx + 1} = data(8*subj_idx+j+3).name;
    end
    % collect SC - FC matrices
    sCall(:,:,subj_idx+1) = dlmread(strcat(pth, data_names{1,subj_idx+1}));
    fCall(:,:,subj_idx+1) = dlmread(strcat(pth, data_names{5,subj_idx+1}));
    % collect center of mass for all regions in the subject
    subj_com(:, :, subj_idx + 1) = csvread(strcat(pth, data_names{4, subj_idx + 1}));
end

% collect age information
ages = dlmread(strcat(pth, data(1580).name)); % file with age list, may change with data sets.
end

