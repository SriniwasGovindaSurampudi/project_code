function [ order, visited ] = bfs( IDX, roi_coord, num_nbrs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% correct ordering will come in order
order = zeros(size(IDX, 1), 1);
visited = zeros(size(IDX, 1), 1);

head = 1;
tail = 1;

% starting the search
[~, r_idx] = max(roi_coord(:, 2));
order(tail, 1) = r_idx;
visited(r_idx, 1) = 1;
tail = tail + 1;

while ((tail - head) > 0)
    roi_head = order(head, 1);
    for i = 2 : num_nbrs
        r_idx = IDX(roi_head, i);
        if (~visited(r_idx, 1))
            visited(r_idx, 1) = 1;
            order(tail, 1) = r_idx;
            tail = tail + 1;
        end
    end
    head = head + 1;
end

end

