function [Emsi,psnr] = DeNoising_tucker_mdl(Nmsi,par,Omsi)
% MSI denoising based on Tucker-MDL
%==========================================================================
sizeData   = size(Nmsi);
Emsi       = Nmsi;
% [Sel_arr]  = nonLocal_arr(sizeData, par); % PreCompute the all the patch index in the searching window
Average         =   mean(Nmsi,3);
[Neighbor_arr, Num_arr, Sel_arr] =	NeighborIndex(Average, par);  
L          = length(Sel_arr);
%% main loop
tic
for  iter = 1 : par.deNoisingIter
    Curmsi      	= Emsi + par.delta*(Nmsi - Emsi);
    Average         =   mean(Curmsi,3);
    [Curpatch, Mat]	=	Im2Patch1( Curmsi, Nmsi, Average, par);
    sizePatch  = size(Curpatch);
    % Caculate Non-local similar patches for each
    if (mod(iter-1,1)==0)
        index  =  Block_matching_my(Mat, par, Neighbor_arr, Num_arr, Sel_arr);
        patnum = par.patnum;
        par.patnum = par.patnum - 10;
    end
   
    Epatch          = zeros(sizePatch);
    W               = zeros([sizePatch(1:2),sizePatch(4)],'single');
    
    fprintf('tensorSVD of iter %f has been done          ', iter);
    fprintf('\n')
    sizePart  =  5100;
    numPart   =  floor(L/sizePart)+1;
    sizeY = [sizePatch(3),sizePatch(1:2),patnum]; 
    R = par.R;
    for i = 1:numPart
        PattInd = (i-1)*sizePart+1:min(L,i*sizePart);
        tempInd = index(:,PattInd);
        sizeInd = size(tempInd);
        tempPatch = Curpatch(:,:,:,tempInd(:));
        tempPatch = reshape(tempPatch, [sizePatch(1:3), sizeInd]);
%         for j = 1:sizeInd(2)
        parfor j = 1:sizeInd(2) 
            %% HOSVD
            Y = permute(tempPatch(:,:,:,:,j),[3,1,2,4]);
            deY = hosvd_mdl(Y, []);
%             deY = hosvd_mdl(Y,R);   % use the tuned/suggested ranks if need
            tempPatch(:,:,:,:,j) = permute(deY,[2,3,1,4]);
        end
        for j = 1:sizeInd(2)
            Epatch(:,:,:,tempInd(:,j))  = Epatch(:,:,:,tempInd(:,j)) + tempPatch(:,:,:,:,j);
            W(:,:,tempInd(:,j))         = W(:,:,tempInd(:,j))+1;
        end
        if i/numPart<0.1
            fprintf('\b\b\b\b\b\b\b %2.2f%% ', i/numPart*100);
        else
            fprintf('\b\b\b\b\b\b\b\b %2.2f%% ', i/numPart*100);
        end
    end
    clear Curpatch;
    fprintf('\n')
    
    clear tempPatch
    time = toc;
    %% recconstruct the estimated MSI by aggregating all reconstructed FBP goups.
    [Emsi, ~]  =  Patch2Im1( Epatch, W, par, sizeData);
    clear Epatch;
    if par.OutPSNR
        psnr(iter)       =  PSNR3D(Emsi,Omsi);
        disp(['Iter: ' num2str(iter),' , current PSNR = ' num2str(psnr(iter)), ',  already cost time: ', num2str(time)]);
        %         figure;imshow(Emsi(:,:,end));pause(0.5);
    else
        psnr = [];
        disp(['Iter: ' num2str(iter),'   done,  already cost time: ', num2str(time)]);
    end
end
end
