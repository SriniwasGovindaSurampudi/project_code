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
% checking if all subjects have the same coordinates set in the same order.
s = 0;
for subj_idx = 1 : num_subjs
    s = s + sum(sum(subj_com(:, :, 1) - subj_com(:, :, subj_idx)));
end
%% organizing the rois through coordinates
% take avg subj coords
roi_coord = squeeze(subj_com(:, :, 197));
% separate left and right part of the brain
left_coord = [];
right_coord = [];
left_roi_ind = [];
right_roi_ind = [];
for coord_idx = 1 : size(roi_coord, 1)
    if (roi_coord(coord_idx, 1) <= 0.5)
        left_coord = [left_coord; roi_coord(coord_idx, :)];
        left_roi_ind = [left_roi_ind; coord_idx];
    else
        right_coord = [right_coord; roi_coord(coord_idx, :)];
        right_roi_ind = [right_roi_ind; coord_idx];
    end
end

%% on left part
% knn neighbors
num_nbrs = 5;
[IDX_left, ~] = knnsearch(left_coord, left_coord, 'K', num_nbrs);
%%{
% run bfs 
[ order_left, visited_left ] = bfs( IDX_left, left_coord, num_nbrs );

% change ordering 
left_roi_ind = left_roi_ind(order_left, :);
%}
%% on roght part
% knn neighbors
num_nbrs = 5;
[IDX_right, ~] = knnsearch(right_coord, right_coord, 'K', num_nbrs);
%%{
% run bfs
[ order_right, visited_right ] = bfs( IDX_right, right_coord, num_nbrs );

% change ordering
right_roi_ind = right_roi_ind(order_right, :);
%}
%% ordering all rois
order_roi = [right_roi_ind; left_roi_ind];
sCall = sCall(order_roi, order_roi, :);
fCall = fCall(order_roi, order_roi, :);
%% saving the data
save('/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/SC-FC_proper', 'sCall', 'fCall');



















