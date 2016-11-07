% plotting data clusters
figure;
for i = 1 : k
    idx = find(idx_n2 == i);
    scatter3(x(idx),y(idx),z(idx),[],repmat([rand(1),rand(1),rand(1)],length(idx),1));
    hold on;
end
hold off;