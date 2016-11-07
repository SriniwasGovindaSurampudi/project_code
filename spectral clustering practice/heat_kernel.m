%% data
close 
clc
data1
%% laplacian
%W = W_k;
n = 400;
k = 2;
D = diag(sum(W));
L = diag(ones(size(x,2),1)) - D^(-1/2)*W*D^(-1/2);
[V_un,Diag_un] = eig(L);
%% heat kernel
original = figure;
% embedding = figure;
figure(original)
axis([2 6 2 6 0 0.5]);
%heat_init = zeros(size(x,2),1); %heat_init(round(size(x,2)*rand(1)),1) = 1;
heat_init = rand(size(x,2),1);
scatter3(x,y,z,[],heat_init)
% figure(embedding)
% axis([-1*10^(-3) 1*10^(-3) -4*10^(0) 4*10^(0) -3*10^(-17) 3*10^(-17)]);
% Embedding = V_un * diag(exp((-1/2)*sum(Diag_un,2)));
% scatter3(Embedding(:,2),Embedding(:,3),Embedding(:,4),[],10*heat_init);

t = 0;
err = inf;
heat_distr = heat_init;
while (err > 1e-12)
    E = diag(exp((-t)*sum(Diag_un,2)));
    Heat_kernel = V_un * E * V_un';
    heat_distribution = Heat_kernel * heat_init;
%     Embedding = V_un * diag(exp((-t/2)*sum(Diag_un,2)));
%     figure(embedding)
%     scatter3(Embedding(:,2),Embedding(:,3),Embedding(:,4),[],10*heat_distribution);
    %figure(original)
    scatter3(x,y,z,[],heat_distribution);
    pause(0.05);
    err = sum(abs(heat_distribution - heat_distr));
    heat_distr = heat_distribution;
    t = t + 1;
end