for n = 1 : 10
    a = randn(size(alpha)) + alpha;
    for i = 1 : p
        A(:,:,i) = diag(a(i,:));
    end
    for l = 1 : L
        % SC pre-processing
        nzs = nonzeros(sCall(:,:,l));
        MapC =((sCall(:,:,l) > 0.1*std(nzs))) .* sCall(:,:,l);
        NormMean = mean(nonzeros(MapC));
        MapC = MapC/NormMean; % Normalize struct matrix
        clear NormMean;
        
        % FC pre-processing
        tmp = fCall(:,:,l);
        inds = (abs(fCall(:,:,l)) > 0.05*max(abs(tmp(:))));
        %inds(1:91:end) = 0;
        
        % set of heat kernels
        H = Kernels_version2(MapC,p);
        for i = 1 : p
            pred_FC(:,:,l) = pred_FC(:,:,l) + H(:,:,i)*A(:,:,i);
        end
        c = corrcoef(pred_FC(:,:,l).*inds,abs(fCall(:,:,l).*inds));
        corr(n,l) = c(1,2);
    end
end
max(corr) - best_corr

%surf(corr)