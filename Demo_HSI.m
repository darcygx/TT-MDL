clc;
clear;close all;
addpath(genpath('lib'));

%% Load data
load('data\CAVE_feathers.mat');            % please make sure you have enough computer memory (at least 16G).  
sigma = 20;                                          % noisy hsi with sigma=10
noisy_msi = msi + sigma*randn(size(msi));

%% Set enable bits
par.delta              =   0.1;                     % parameter between each iterative refinement
par.OutPSNR       =   1;                        % show the iterative results or not
par.patsize           =   6;                        % patch size
par.deNoisingIter =   5;                        % total iteration numbers
par.step               =   floor((par.patsize-1));
par.patnum          =   200;                     % initial Non-local Patch number
par.SearchWin      =   40;
 
%% TT-MDL
par.R                    = [10,30,30];              % use the tuned/suggested TT ranks if need
tic;
[Re_msi,~] = DeNoising_tt_mdl(noisy_msi, par,msi); 
Time = toc;
[psnr, ssim, ~, ergas, sam] = MSIQA(msi, Re_msi);
disp([' done in ' num2str(Time), ' s.'])
disp([sprintf(' PSNR=%.2f SSIM=%.2f ERGAS=%.2f SAM=%.2f.',psnr,ssim,ergas,sam)])

%% Tucker-MDL
par.R                  = [10,6,6,30];                % use the tuned/suggested Tucker ranks if need
tic;
[Re_msi,~] = DeNoising_tucker_mdl(noisy_msi, par,msi); 
Time = toc;
[psnr, ssim, ~, ergas, sam] = MSIQA(msi, Re_msi);
disp([' done in ' num2str(Time), ' s.'])
disp([sprintf(' PSNR=%.2f SSIM=%.2f ERGAS=%.2f SAM=%.2f.',psnr,ssim,ergas,sam)])