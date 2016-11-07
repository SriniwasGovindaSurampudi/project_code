%%{
clear
close all
clc
%%
pth = '../../../data/static_SC-FC/NKI_Rockland/data/';
[~, ~, data_names, ~] = Collect_NKI_Rockland_Data( pth );
%% within subject variation in roi_names
for i = 1 : size(data_names, 2)
    fid = fopen(data_names{3, i});
    dti_names = textscan(fid, '%s', 'delimiter', '\n');
    dti_names = dti_names{1, 1};
    fclose(fid);
    
    fid = fopen(data_names{7, i});
    fmri_names = textscan(fid, '%s', 'delimiter', '\n');
    fmri_names = fmri_names{1, 1};
    fclose(fid);
    
    for j = 1 : size(fmri_names, 1)
        if (~strcmp(fmri_names{j, 1}, dti_names{j, 1}))
            pause;
        end
    end
end
% NO CHANGE FOUND! :-)
%% between subjects and average names

fid = fopen(data_names{3, size(data_names, 2)});
avg_dti_names = textscan(fid, '%s', 'delimiter', '\n');
avg_dti_names = avg_dti_names{1, 1};
fclose(fid);
avg_dti_names_u = unique(avg_dti_names);
avg_dti_names_u_s = sort(avg_dti_names_u);

for i = 3 : size(data_names, 2)
    fid = fopen(data_names{3, i});
    dti_names = textscan(fid, '%s', 'delimiter', '\n');
    dti_names = dti_names{1, 1};
    fclose(fid);
    
    dti_names_u = unique(dti_names);
    dti_names_u_s = sort(dti_names_u);
    
    for j = 1 : size(dti_names_u_s, 1)
        
    end
end
%}
%{
s = zeros(1, size(data_names, 2));
for i = 1 : size(data_names, 2)
    fid = fopen(data_names{3, i});
    dti_names = textscan(fid, '%s', 'delimiter', '\n');
    dti_names = dti_names{1, 1};
    fclose(fid);
    
    s(1, i) = size(sort(unique(dti_names)), 1);
end
plot(s)
%}