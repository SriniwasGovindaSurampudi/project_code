clear
close all
clc
%% collect CC200 labels and center of mass
pth = '../../../data/';
[CC200_labels, CC200_centerOfMass] = extract_CC200(pth);
%% collect NKI_Rockland data
pth = '../../../data/static_SC-FC/NKI_Rockland/data/';
[sCall, fCall, data_names, ages, subj_com] = Collect_NKI_Rockland_Data(pth);
%% presence of rois in subjects
[num_rois, ~]  = size(CC200_centerOfMass);
[~, num_subjs] = size(data_names);
% roi_in_subj = zeros(num_rois, num_subjs);
% for roi_idx = 1 : num_rois
%     for subj_idx = 1 : num_subjs
%         for r_idx = 1 : size(sCall, 1)
%             if isequal(subj_com(r_idx, :, subj_idx), CC200_centerOfMass(roi_idx, :))
%                 roi_in_subj(roi_idx, subj_idx) = 1;
%             end
%         end
%     end
% end
s = 0;
for subj_idx = 1 : num_subjs
    s = s + sum(sum(subj_com(:, :, 1) - subj_com(:, :, subj_idx)));
end