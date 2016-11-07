% plotting input data
for i = 1 : 400
    ind = find(W_k(i,:) ~= 0);
    x_ind = x(ind);
    y_ind = y(ind);
    z_ind = z(ind);
    x_1 = x(i)*ones(length(ind));
    y_1 = y(i)*ones(length(ind));
    z_1 = z(i)*ones(length(ind));
    a = [x_1;x_ind]; b = [y_1;y_ind]; c = [z_1;z_ind];
    line(a,b,c,'color',[0.6 0.6 0.6])
end