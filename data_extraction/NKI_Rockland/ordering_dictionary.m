%{
close all
clear
% clc
%% collecting regions' names

% disp({'change the folder containing roi_188_full_names.txt file'; 'press enter when changed'});
% pause;

pth = '../../../data/static_SC-FC/NKI_Rockland/';
fid = fopen([pth, 'roi_188_full_names.txt']);
ordered_names = textscan(fid, '%s', 'delimiter', '\n');
ordered_names = ordered_names{1, 1};
fclose(fid);

% disp({'change folder back'; 'press enter when changed'});
% pause;

%% dictionary of sorted names and their corresponding indices

roi_order = containers.Map();

key_list = unique(ordered_names);
for i = 1 : size(key_list, 1)
    roi_name = key_list{i, 1};
    val_list = [];
    for j = 1 : size(ordered_names, 1)
        if (strcmp(roi_name, ordered_names{j, 1}))
            val_list = [val_list, j];
        end
    end
    roi_order(roi_name) = val_list;
end

%% index mapping

pth = [pth, '/data/'];
fid = fopen([pth, '2362594_DTI_region_names_full_file.txt']);
unordered_names = textscan(fid, '%s', 'delimiter', '\n');
unordered_names = unordered_names{1, 1};
fclose(fid);

correct_index_order = zeros(size(ordered_names));

for i = 1 : roi_order.Count
    roi_name = key_list{i, 1};
    idx_temp = [];
    for j =  1 : size(unordered_names, 1)
        if (strcmp(roi_name, unordered_names{j, 1}))
            idx_temp = [idx_temp, j];
        end
    end
    if (size(idx_temp, 2) == size(roi_order(key_list{i, 1}), 2))
        correct_index_order(idx_temp) = roi_order(key_list{i, 1});
    else
        i
        idx_temp
        roi_order(key_list{i, 1})
    end
    
end
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clc
tic;
pth = '../../../data/static_SC-FC/NKI_Rockland/data/';
[~, ~, data_names, ~] = Collect_NKI_Rockland_Data( pth );

for subj_idx = 1 : size(data_names, 2)
    % read a subject's roi full names
    fid = fopen(data_names{3, subj_idx});
    unordered_names = textscan(fid, '%s', 'delimiter', '\n');
    unordered_names = unordered_names{1, 1};
    fclose(fid);
    
    parts = cell(3, 1);
    left_part = {};
    right_part = {};
    other_part = {};
    
    for r_idx = 1 : size(unordered_names, 1)
        % replace Right Heschl's region to Right Transverse Temporal
        if (size(strfind(unordered_names{r_idx, 1}, 'Heschl')) ~= 0)
            unordered_names{r_idx, 1} = 'Right Transverse Temporal';
        end
        if (size(strfind(unordered_names{r_idx, 1}, 'Right')) ~= 0)
            right_part = [right_part; unordered_names(r_idx, 1)];
        elseif (size(strfind(unordered_names{r_idx, 1}, 'Left')) ~= 0)
            left_part = [left_part; unordered_names(r_idx, 1)];
        else
            other_part = [other_part; unordered_names(r_idx, 1)];
        end
    end
    % sort all regions in ascensing order
    [right_part, sort_id_r] = sort(right_part);
    [left_part, sort_id_l] = sort(left_part);
    [other_part, sort_id_o] = sort(other_part);
    
    parts{1, 1} = right_part;
    parts{2, 1} = left_part;
    parts{3, 1} = other_part;
    
    for prt = 1 : 2
        frontal = {};
        parietal = {};
        occipital = {};
        temporal = {};
        other = {};
        for r_idx = 1 : size(parts{prt, 1}, 1)
            if     (size(strfind(parts{prt, 1}{r_idx, 1}, 'Frontal')) + ...
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Opercular')) ~= 0)
                frontal = [frontal; parts{prt, 1}(r_idx, 1)];
            elseif (size(strfind(parts{prt, 1}{r_idx, 1}, 'Parietal')) + ...
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Cingulate')) + ...
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Central')) + ... 
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Marginal')) + ...
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Pre')) + ...
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Post')) ~= 0)
                parietal = [parietal; parts{prt, 1}(r_idx, 1)];
            elseif (size(strfind(parts{prt, 1}{r_idx, 1}, 'Occipital')) + ...
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Lingual')) ~= 0)
                occipital = [occipital; parts{prt, 1}(r_idx, 1)];
            elseif (size(strfind(parts{prt, 1}{r_idx, 1}, 'Temporal')) + ...
                    size(strfind(parts{prt, 1}{r_idx, 1}, 'Crus')) ~= 0)
                temporal = [temporal; parts{prt, 1}(r_idx, 1)];
            else
                other = [other; parts{prt, 1}(r_idx, 1)];
            end
        end
        parts{prt, 1} = [frontal; parietal; occipital; temporal; other];
    end
    roi_names_order = [parts{1, 1}; parts{3, 1}; parts{2, 1}]; 
    
end
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%