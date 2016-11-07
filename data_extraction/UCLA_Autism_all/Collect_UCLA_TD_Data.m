function [ all_files, collected_names, all_subject_names, both_subject_names ] ...
			= Collect_UCLA_TD_Data( path )  %all_subject_age )
%UNTITLED Summary of this function goes here
%   gives all file names.
%   need to extract data out of files.
% all files
all_files = dir(path);

% one type together, i.e 4 files in a row.
n = ( size(all_files, 1) - 2)/ 4;
collected_names = cell(n, 4);
for i = 3 : size(all_files, 1)
    collected_names{floor((i - 3)/ 4) + 1, mod(i - 3, 4) + 1} = all_files(i).name;
end

all_subject_names = [];
both_subject_names = [];
both_subject_age = [];
i = 1;
while i <= n - 1
    e = regexp(collected_names{i, 1}, '\d');
    % if same number ...
    if (sum(collected_names{i, 1}(e) == collected_names{i + 1, 1}(e)) / size(e, 2) == 1)
        sub = cell(2, 4);
        % DTI-fMRI ?
        if (size(strfind(collected_names{i, 1}, 'DTI'), 1))
            sub(1, :) = collected_names(i, :);
            sub(2, :) = collected_names(i + 1, :);
        % fMRI-DTI ?
        else
            sub(2, :) = collected_names(i, :);
            sub(1, :) = collected_names(i + 1, :);
        end
        all_subject_names = [all_subject_names; {sub}];
        both_subject_names = [both_subject_names; {sub}];
        i = i + 2;
    % if not same number ...
    else
        sub = cell(2, 4);
        % DTI ?
        if (size(strfind(collected_names{i, 1}, 'DTI'), 1))
            sub(1, :) = collected_names(i, :);
            % fMRI ?
        else
            sub(2, :) = collected_names(i, :);
        end
        all_subject_names = [all_subject_names; {sub}];
        i = i + 1;
    end
end

% % extracting names of regions
% FC_names = cell(264, 1);
% fid = fopen([path, both_subject_names{1, 1}{2, 3}]);
% for i = 1 : 264
%     f = fgetl(fid);
%     FC_names{i, 1} = f;
% end
% fclose(fid);
% 
% SC_names = cell(264, 1);
% fid = fopen([path,both_subject_names{1, 1}{1, 3}]);
% for i = 1 : 264
%     f = fgetl(fid);
%     SC_names{i, 1} = f;
% end
% fclose(fid);

% % extracting coordinates of regions
% SC_coordinates = dlmread(both_subject_names{1, 1}{1, 4});
% FC_coordinates = dlmread(both_subject_names{1, 1}{2, 4});

end