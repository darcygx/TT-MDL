clc;
clear;close all;
addpath(genpath('lib'));

testnum = 10;                  % test number
order = 4;                        % tensor order
I = [10,10,10,10];              % tensor dimensions
err_aXr1 = zeros(9,9);
err_aXr2 = zeros(9,9);
SNR = 5;                         % signal to noise ratio
sigma = sqrt(1/(10^(SNR/10)));
% randn('state',0)
for a = 1:9
    for r = 1:9
        R = [1,a,r,a,1];
        err1 = [];
        err2 = [];
        for t = 1:testnum
            %% add Gaussian noise
            x = tt_random(I,order,R);
            X = reshape(full(x),I);
            energy_inv = sqrt(prod(I))/norm(X(:));
            X = energy_inv*X;   %<-- normalization
            GN =  sigma*randn(I);  %<-- dense
            Y = X + GN;
            
            %% calculate the Tucker ranks
            prodI = prod(I);
            for i = 1:order
                X_ci = tens2mat(X,i);
                Tucker_rank(i) = rank(X_ci);
            end
        
             %% calculate the TT ranks
            prodI = prod(I);
            for i = 1:(order-1)
                idx = prod(I(1:i));
                X_ci = reshape(X,[idx, prodI/idx]);
                TT_rank(i) = rank(X_ci);
            end
%             disp(['a= ',int2str(a),',r= ',int2str(r), ',Tucker=',int2str(Tucker_rank), ',TT=',int2str(TT_rank)]);
            
            %% HOSVD-based denoising
%             Y1 = hosvd_mdl(Y,[]);  % <-- Figure 1.(b)
            Y1 = hosvd_mdl(Y,Tucker_rank); % <-- Figure 1.(a)
            err1(t) = mse(X(:),Y1(:));
            
            %% TTSVD-based denoising
%             tt = ttsvd_mdl(Y,[]);  % <-- Figure 1.(b)
            tt = ttsvd_mdl(Y,TT_rank);  % <-- Figure 1.(a)
            Y2 = full(tt);
            err2(t) = mse(X(:),Y2(:));
        end
        mean_e1 = mean(err1);
        mean_e2 = mean(err2);
        err_aXr1(a,r) = mean_e1;
        err_aXr2(a,r) = mean_e2;
    end
end
imagesc(err_aXr1-err_aXr2);
colormap(jet);
colorbar