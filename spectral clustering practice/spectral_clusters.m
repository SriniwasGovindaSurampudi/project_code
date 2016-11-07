%% initialization
%W = W_k;
n = 188;
k = 10;
%load('graph.mat');
%W = A + A';
D = diag(sum(W));
% for i = 1:n
%     D(i,i) = sum(W(i,:));
% end
%% unnormalized clustering
L = D - W;
[V_un,Diag_un] = eig(L);

%figure,plot(sum(Diag_un))

%V_reduced_un = V_un(:,2:k+1);
V_reduced_un = V_un(:,1:k);

[idx_un,centers_un] = kmeans(V_reduced_un,k);
Clusters_un = zeros(n,k);
for i = 1:n
    Clusters_un(i,idx_un(i)) = 1;
end
%% normalized clustering Shi and Malik
Lrw = D^(-1) * L;
[V_n1,Diag_n1] = eig(Lrw);

s = sum(Diag_n1);
[~,idx] = sort(s);
Diag_n1 = Diag_n1(:,idx);

%figure, plot(sum(Diag_n1))

V_n1 = V_n1(:,idx);
%V_reduced_n1 = V_n1(:,2:k+1);
V_reduced_n1 = V_n1(:,1:k);

[idx_n1,centers_n1] = kmeans(V_reduced_n1,k);
Clusters_n1 = zeros(n,k);
for i = 1:n
    Clusters_n1(i,idx_n1(i)) = 1;
end
%% normalized clustering Ng, Jordan and Weiss
Lsym = D^(-1/2) * L * D^(-1/2);
[V_n2,Diag_n2] = eig(Lsym);

s = sum(Diag_n2);
[~,idx] = sort(s);
Diag_n2 = Diag_n2(:,idx);

%figure, plot(sum(Diag_n2))

V_n2 = V_n2(:,idx);
abs_V_n2 = sqrt(sum(V_n2.^2,2));
V_n2 = bsxfun(@rdivide, V_n2, abs_V_n2);
%V_reduced_n2 = V_n2(:,2:k+1);
V_reduced_n2 = V_n2(:,1:k);

[idx_n2,centers_n2] = kmeans(V_reduced_n2,k);
Clusters_n2 = zeros(n,k);
for i = 1:n
    Clusters_n2(i,idx_n2(i)) = 1;
end