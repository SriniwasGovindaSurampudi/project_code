%% data formation
close all;
theta1 = linspace(0,pi,200);
theta2 = linspace(pi,2*pi,200);
x1 = cos(theta1) + rand(1,200) + 3;
x2 = cos(theta2) + rand(1,200) + 4;
y1 = sin(theta1) + rand(1,200) + 3.75;
y2 = sin(theta2) + rand(1,200) + 3.25;
z1 = 0.5*rand(1,200); z2 = 0.5*rand(1,200);
scatter3(x1,y1,z1); hold on; scatter3(x2,y2,z2);
x = [x1,x2]; y = [y1,y2]; z = [z1,z2];
%% similarity measurements
% v1 v1 
[v_x1_x1_x,v_x1_x1_y] = meshgrid(x1,x1);
[v_y1_y1_x,v_y1_y1_y] = meshgrid(y1,y1);
[v_z1_z1_x,v_z1_z1_y] = meshgrid(z1,z1);
v11_dist = (v_x1_x1_x - v_x1_x1_y).^2 + (v_y1_y1_x - v_y1_y1_y).^2 + (v_z1_z1_x - v_z1_z1_y).^2;
v11_dist(v11_dist == 0) = inf;
v11 = exp(-v11_dist);
% v1 v2 
[v_x1_x2_x,v_x1_x2_y] = meshgrid(x1,x2);
[v_y1_y2_x,v_y1_y2_y] = meshgrid(y1,y2);
[v_z1_z2_x,v_z1_z2_y] = meshgrid(z1,z2);
v12_dist = (v_x1_x2_x - v_x1_x2_y).^2 + (v_y1_y2_x - v_y1_y2_y).^2 + (v_z1_z2_x - v_z1_z2_y).^2;
v12_dist(v12_dist == 0) = inf;
v12 = exp(-v12_dist);
% v2 v2
[v_x2_x2_x,v_x2_x2_y] = meshgrid(x2,x2);
[v_y2_y2_x,v_y2_y2_y] = meshgrid(y2,y2);
[v_z2_z2_x,v_z2_z2_y] = meshgrid(z2,z2);
v22_dist = (v_x2_x2_x - v_x2_x2_y).^2 + (v_y2_y2_x - v_y2_y2_y).^2 + (v_z2_z2_x - v_z2_z2_y).^2;
v22_dist(v22_dist == 0) = inf;
v22 = exp(-v22_dist);
% gaussian similarity adjacency matrix
W_gauss = [v11,v12;v12',v22];
% mutual k nearset neighbour adjacency matrix
% choose k as nearly log(400)
k = round(log(length(x1)+length(x2)));
W_k = zeros(size(W_gauss));
X = [x',y',z'];
Y = X;
[knn_idx,knn_dist] = knnsearch(X,Y,'k',k);
for i =1:400
    for j = 2:6
        id = knn_idx(i,j);
        W_k(i,id) =  W_gauss(i,id);
    end
end
% checking for symmetric W_k
for i = 1 : size(W_k,1)
    for j = i+1 : size(W_k,2)
       if(~((W_k(i,j) ~= 0) && (W_k(j,i) ~= 0)))
           W_k(i,j) = W_k(i,j) + W_k(j,i);
           W_k(i,j) = W_k(j,i);
       end
    end
end