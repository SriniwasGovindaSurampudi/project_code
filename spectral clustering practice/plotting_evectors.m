%% plotting eigenvecors
%% initialization
xs1=-1; xs2=0; xs3=0; ys1=0; ys2=-1; ys3=0; zs1=0; zs2=0; zs3=-1;
xe1=1; xe2=0; xe3=0; ye1=0; ye2=1; ye3=0; ze1=0; ze2=0; ze3=1;

a = 5*[xs1 xs2 xs3;xe1 xe2 xe3]; b = 5*[ys1 ys2 ys3;ye1 ye2 ye3]; c = 5*[zs1 zs2 zs3; ze1 ze2 ze3];
% 
%% transformations
ip_coord = [a(:)';b(:)';c(:)';ones(1,6)];
figure
plot_input_data;
[Rotation,Translation] = transformation(pi/4,[5 0 0]);
op_coord = Translation * Rotation * ip_coord;
a = [op_coord(1,1:2:end);op_coord(1,2:2:end)];
b = [op_coord(2,1:2:end);op_coord(2,2:2:end)];
c = [op_coord(3,1:2:end);op_coord(3,2:2:end)];
line(a,b,c,'color',[1 0 0]);
V = Translation * Rotation * [100*V_un(:,1:3)';ones(1,400)];
join_data(x,y,z,V(1:3,:)',idx_un,3);
scatter(V(1,:),V(2,:),V(3,:));
% ----------------------------------
% figure
% plot_input_data;
% [Rotation,Translation] = transformation(pi/4,[0 5 0]);
% op_coord = Translation * Rotation * ip_coord;
% a = [op_coord(1,1:2:end);op_coord(1,2:2:end)];
% b = [op_coord(2,1:2:end);op_coord(2,2:2:end)];
% c = [op_coord(3,1:2:end);op_coord(3,2:2:end)];
% line(a,b,c,'color',[1 0 0]);
% V = Translation * Rotation * [100*V_n1(:,1:3)';ones(1,400)];
% join_data(x,y,z,V(1:3,:)',idx_n1,3);
% scatter(V(1,:),V(2,:),V(3,:));
% ----------------------------------
% figure
% plot_input_data;
% [Rotation,Translation] = transformation(pi/4,[0 0 5]);
% op_coord = Translation * Rotation * ip_coord;
% a = [op_coord(1,1:2:end);op_coord(1,2:2:end)];
% b = [op_coord(2,1:2:end);op_coord(2,2:2:end)];
% c = [op_coord(3,1:2:end);op_coord(3,2:2:end)];
% line(a,b,c,'color',[1 0 0]);
% V = Translation * Rotation * [100*V_n2(:,1:3)';ones(1,400)];
% join_data(x,y,z,V(1:3,:)',idx_n2,k);
% scatter(V(1,:),V(2,:),V(3,:));
