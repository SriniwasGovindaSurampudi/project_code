% %% initialization
% x = [x1,x2];
% y = [y1,y2];
% z = [z1,z2];
%% unnormalized 

%figure; title('unnormalized')

grid on

%% normalized n1

%figure; title('normalized n1')

grid on

%% normalized n2

%figure; title('normalized n2')
V = T * R * [V_n2(:,1:3)';ones(1,400)];
join_data(x,y,z,V(1:3,:)',idx_n2,k);
grid on
