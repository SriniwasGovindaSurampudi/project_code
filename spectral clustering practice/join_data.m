function [] = join_data( x,y,z,V,idx,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i = 1 : k
    id = find(idx == i);
    a = [x(id);V(id,1)'];
    b = [y(id);V(id,2)'];
    c = [z(id);V(id,3)'];
    d = [rand(1),rand(1),rand(1)];
    line(a,b,c,'Color',d);
    hold on
    scatter3(x(id),y(id),z(id),[],d);
end
grid on
end

