function [result] = MultipleKernels_version2(sCall, fCall, m)
%{
result{1,1} = ALPHA;
result{1,2} = corr;
result{1,3} = pred_FC;
result{1,4} = alpha;
result{1,5} = H;
result{1,6} = alpha;
%}
%load('/Users/govinda/Desktop/spring2016/Original Authors code/fC_to_sC_Mtx.mat')

L = size(fCall,3); % number of samples
n = size(fCall,1); % number of ROIs
%p = 16; % number of kernels
H = cell(1,L); % set of kernels per sample
Psi = zeros(n*L,n,m); % H^{l} stack
Phi = zeros(n*L,n); % FC stack
alpha = zeros(m,1,n); % \alpha per one column
ALPHA = zeros(n,n,m); % \alpha matrices for each scale
lambda1 = 10^(-5)*rand(1,1); % lagrangian for $\sum_{i = 1}^{p} \alpha_{i} = 1$
lambda2 = 0.1; % lagrange multiplier for $\alpha_{i} > 0$
result = cell(1,5);
J_cost = zeros(n,1);
epsilon = 0.0000;
%*************************************************************************%
% training
%*************************************************************************%
for l = 1 : L % subjects
    % pre-processing
    [ MapC, inds ] = pre_process( sCall(:,:,l), fCall(:,:,l) );
%     MapC = sCall(:,:,l);
%     inds = fCall(:,:,l) > -inf;

    % thresholding SC
    MapC = (MapC > epsilon*max(MapC(:))) .* MapC;
    
    % set of heat kernels
    [H{l}] = Kernels_version2(MapC,m);
    
    % forming \Phi and \Psi matrices
    Psi((l-1)*n+1:l*n,:,:) = H{l};
    Phi((l-1)*n+1:l*n,:) = abs(fCall(:,:,l).*inds); % compare with abs of FC
    %Phi((l-1)*n+1:l*n,:) = (fCall(:,:,l).*inds);
end

%*************************************************************************%
% calculate \ALPHA
%*************************************************************************%
%%{
for j = 1 : n
    P = squeeze(Psi(:,j,:));
    %alpha(:,j) = pinv(P) * Phi(:,j);
    %gamma = (-1).*rand(p,1) + rand(1,1).*ones(p,1);
    alpha(:,j) = (P'*P)\(P'*Phi(:,j) + lambda1*ones(m,1));
    
%     % normalize alpha(:,j)
%     alpha(:,j) = (alpha(:,j) - min(alpha(:,j))) / (max(alpha(:,j)) - min(alpha(:,j)));
%     alpha(:,j) = alpha(:,j) / sum(alpha(:,j));
end
%}

%{
for j = 1 : n
    [J_cost(j,1), alpha(:,j)] = cost_function(inf, 0, -1000, 1000, squeeze(Psi(:,j,:)), Phi(:,j), p);
end
%}

%{
% quadratic programming solution
for j = 1 : n
    P = squeeze(Psi(:,j,:));
    %[alpha(:,j), fval, exitflag, o_p, lambda] = quadprog(P'*P, -2*Phi(:,j)'*P, [], [], double(ones(1,m)), [1], double(zeros(m,1)), double(ones(m,1)));
    %[alpha(:,j), fval, exitflag, o_p, lambda] = quadprog(P'*P, -2*Phi(:,j)'*P, [], [], double(ones(1,m)), [1], [],[]);
    %[alpha(:,j), fval, exitflag, o_p, lambda] = quadprog(P'*P, -2*Phi(:,j)'*P, [], [], [],[], [],[]);
end
%}
% reshaping alpha into diagonal matrix set
for i = 1 : m
    ALPHA(:,:,i) = diag(alpha(i,:));
end
%clear alpha

%*************************************************************************%
% testing
%*************************************************************************%
%pred_FC = zeros(n,n,L);
%corr = zeros(1,L);
[ corr, pred_FC ] = testing( sCall, fCall , m, ALPHA);

result{1,1} = ALPHA;
result{1,2} = corr;
result{1,3} = pred_FC;
result{1,4} = alpha;
result{1,5} = H;
result{1,6} = alpha;
end