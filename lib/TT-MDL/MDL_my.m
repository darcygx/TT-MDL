% estimate rank
function [R] = MDL_my(X)

% Compute eigenvalue decomposition
    [p, N] = size(X);
    if p > N
        [N, p] = size(X);
        X= X';
        X = X-repmat(mean(X,2),1,N);
    end
    X = X-repmat(mean(X,2),1,N);
    Z = X*X';
    [~,D] = eig(Z/N);
    
    [l,~] = sort(diag(D)+ 1e-8,'descend');
    mdl0 = [];
    for idr = 1:p
        
        if idr == p
            v = 1e-8;
        else
            v = mean(l(idr+1:p));
        end
        
        mdl0(idr) = -sum(log(l(idr+1:p))) +(p-idr)*log(v) + 0.5*log(N)*idr*(2*p-idr)/N;    % complex, original MDL
%    mdl0(idr) = -sum(log(l(idr+1:p))) +(p-idr)*log(v) + 0.5*log(N)*idr*(p-0.5*idr+0.5)/N;   % real, corrected MDL. 
%   we use this in the Figure 1(b), but we find the original MDL is better.
        
    end
    [~, R] = min(mdl0);
  end


