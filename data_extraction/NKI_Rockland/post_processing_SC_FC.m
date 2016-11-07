% close all
% clear
% clc
% %% all subjects collected
% pth = '../../../data/static_SC-FC/NKI_Rockland/data/';
% [all_Emp_SC, all_Emp_FC, data_names, ages] = Collect_NKI_Rockland_Data(pth);
% %% extracting average roi names
% fid = fopen(data_names{3, size(data_names, 2)});
% avg_dti_names = textscan(fid, '%s', 'delimiter', '\n');
% avg_dti_names = avg_dti_names{1, 1};
% fclose(fid);
% avg_dti_names_u = unique(avg_dti_names);
% avg_dti_names_u_s = sort(avg_dti_names_u);
% %% arranging roi's in F->P->O->T order
% right_part = {};
% left_part  = {};
% other_part = {};
% parts      = cell(3, 1);
% 
% num_rois = size(avg_dti_names_u_s, 1);
% 
% for roi_idx = 1 : num_rois
%     if (size(strfind(avg_dti_names_u_s{roi_idx, 1}, 'Heschl')) ~= 0)
%         avg_dti_names_u_s{roi_idx, 1} = 'Right Transverse Temporal';
%     end
%     if (size(strfind(avg_dti_names_u_s{roi_idx, 1}, 'Right')) ~= 0)
%         right_part = [right_part; avg_dti_names_u_s(roi_idx, 1)];
%     elseif (size(strfind(avg_dti_names_u_s{roi_idx, 1}, 'Left')) ~= 0)
%         left_part = [left_part; avg_dti_names_u_s(roi_idx, 1)];
%     else
%         other_part = [other_part; avg_dti_names_u_s(roi_idx, 1)];
%     end
% end
% 
% parts{1, 1} = right_part;
% parts{2, 1} = left_part;
% parts{3, 1} = other_part;
% 
% % arrange FPOT in every part
% for prt_idx = 1 : 2
%     frontal   = {};
%     parietal  = {};
%     occipital = {};
%     temporal  = {};
%     other     = {};
%     
%     for roi_idx = 1 : size(parts{prt_idx, 1}, 1)
%         if     (size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Frontal')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Opercular')) ~= 0)
%             frontal = [frontal; parts{prt_idx, 1}(roi_idx, 1)];
%         elseif (size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Parietal')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Cingulate')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Central')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Marginal')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Pre')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Post')) ~= 0)
%             parietal = [parietal; parts{prt_idx, 1}(roi_idx, 1)];
%         elseif (size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Occipital')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Lingual')) ~= 0)
%             occipital = [occipital; parts{prt_idx, 1}(roi_idx, 1)];
%         elseif (size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Temporal')) + ...
%                 size(strfind(parts{prt_idx, 1}{roi_idx, 1}, 'Crus')) ~= 0)
%             temporal = [temporal; parts{prt_idx, 1}(roi_idx, 1)];
%         else
%             other = [other; parts{prt_idx, 1}(roi_idx, 1)];
%         end
%     end
%     parts{prt_idx, 1} = [frontal; parietal; occipital; temporal; other];
% end
% 
% avg_dti_names_u_s = [parts{1, 1}; parts{2, 1}; parts{3, 1}];
% 
% %% finding all regions' positions per subject
% roi_idx_subj = cell(size(avg_dti_names_u_s, 1), size(data_names, 2));
% for subj_idx = 1 : size(data_names, 2)
%     % subject specific roi_names
%     fid = fopen(data_names{3, subj_idx});
%     dti_names = textscan(fid, '%s', 'delimiter', '\n');
%     dti_names = dti_names{1, 1};
%     fclose(fid);
%     % finding all the positions
%     for roi_idx = 1 : size(avg_dti_names_u_s, 1)
%         idx = [];
%         % for an roi_name find its positions
%         for r_idx = 1 : size(dti_names, 1)
%             if (strfind(avg_dti_names_u_s{roi_idx, 1}, dti_names{r_idx, 1}))
%                 idx = [idx, r_idx];
%             end
%         end
%         roi_idx_subj{roi_idx, subj_idx} = idx;
%     end
% end
% %% creating new SC-FC pairs
% sCall = zeros(size(avg_dti_names_u_s, 1), size(avg_dti_names_u_s, 1), size(data_names, 2));
% fCall = zeros(size(avg_dti_names_u_s, 1), size(avg_dti_names_u_s, 1), size(data_names, 2));
% for subj_idx = 1 : size(data_names, 2)
%     sc_temp = zeros(size(avg_dti_names_u_s, 1), size(avg_dti_names, 1));
%     fc_temp = zeros(size(avg_dti_names_u_s, 1), size(avg_dti_names, 1));
%     % average along rows
%     for roi_idx = 1 : size(avg_dti_names_u_s, 1)
%         sc_temp(roi_idx, :) = mean(all_Emp_SC(roi_idx_subj{roi_idx, subj_idx}, :, subj_idx), 1);
%         fc_temp(roi_idx, :) = mean(all_Emp_FC(roi_idx_subj{roi_idx, subj_idx}, :, subj_idx), 1);
%     end
%     % average along columns
%     for roi_idx = 1 : size(avg_dti_names_u_s, 1)
%         sCall(:, roi_idx, subj_idx) = mean(sc_temp(:, roi_idx_subj{roi_idx, subj_idx}), 2);
%         fCall(:, roi_idx, subj_idx) = mean(fc_temp(:, roi_idx_subj{roi_idx, subj_idx}), 2);
%     end
%     % remove NaN's
%     sc = sCall(:, :, subj_idx);
%     i = isnan(sc);
%     sc(i) = 0;
%     sCall(:, :, subj_idx) = sc;
%     fc = fCall(:, :, subj_idx);
%     i = find(isnan(fc));
%     fc(i) = 0;
%     fCall(:, :, subj_idx) = fc;
%     % normalize SC-FC
%     M_SC = max(max(sCall(:, :, subj_idx)));
%     sCall(:, :, subj_idx) = sCall(:, :, subj_idx) / M_SC;
% end
% %% saving new SC-FC pairs
% file_name = '/Users/govinda/Desktop/Project/data/static_SC-FC/NKI_Rockland/mat files/SC_FC_94';
% save(file_name, 'sCall', 'fCall', 'avg_dti_names_u_s');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear
clc
%% all subjects collected
pth = '../../../data/static_SC-FC/NKI_Rockland/data/';
[all_Emp_SC, all_Emp_FC, data_names, ages] = Collect_NKI_Rockland_Data(pth);
%% 