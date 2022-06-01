function T = hosvd_mdl(X,R)
% higher-order SVD (Tucker).

%% Read paramters
d = ndims(X);
dimorder = 1:d;

%% Main loop
if isempty(R)
    U = cell(d,1); % allocate space for factor matrices
    R = [];
    for k = dimorder
        Xk = tens2mat(X,k);
        [U{k},~,~] = svd(double(Xk*Xk'));
        R(k) = MDL_my(Xk); % estimate Tucker rank
        U{k} = U{k}(:,1:R(k));
    end
else
    U = cell(d,1); % allocate space for factor matrices
    for k = dimorder
        Xk = tens2mat(X,k);
        [U{k},~,~] = svd(double(Xk*Xk'));
        U{k} = U{k}(:,1:R(k));
    end
end
G = tmprod(X,U,dimorder,'T');
%% Final result
T = tmprod(G,U,dimorder);