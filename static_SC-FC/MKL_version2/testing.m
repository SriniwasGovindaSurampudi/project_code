function [ corr,pred_FC ] = testing( sCall, fCall , m, ALPHA)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[~,n,L] = size(sCall);
pred_FC = zeros(n,n,L);
corr = zeros(1,L);
for l = 1 : L
    % pre-processing
    [ MapC, inds ] = pre_process( sCall(:,:,l),fCall(:,:,l) );
    % set of heat kernels
    H = Kernels_version2(MapC,m);
    for i = 1 : m
        pred_FC(:,:,l) = pred_FC(:,:,l) + H(:,:,i)*ALPHA(:,:,i);
    end
    pred_FC(:,:,l) = (pred_FC(:,:,l)' + pred_FC(:,:,l))/2;
    c = corrcoef(pred_FC(:,:,l).*inds,abs(fCall(:,:,l).*inds));
    %c = corrcoef(pred_FC(:,:,l).*inds,(fCall(:,:,l).*inds));
    corr(1,l) = c(1,2);
end

end

