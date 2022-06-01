function  [Y, Mat]  =  Im2Patch1( E_Img,N_Img, Average, par)
patsize     = par.patsize;
TotalPatNum = (size(E_Img,1)-patsize+1)*(size(E_Img,2)-patsize+1);           %Total Patch Number in the image
Y           =   zeros(patsize, patsize, size(E_Img,3), TotalPatNum, 'single'); %Current Patches
N_Y         =   zeros(patsize, patsize, size(E_Img,3), TotalPatNum, 'single'); %Patches in the original noisy image
Mat         =   zeros(patsize, patsize, TotalPatNum, 'single');               %Patches in the original noisy image

for i  = 1:par.patsize
    for j  = 1:par.patsize
        E_patch     =  E_Img(i:end-par.patsize+i,j:end-par.patsize+j,:);
        N_patch     =  N_Img(i:end-par.patsize+i,j:end-par.patsize+j,:);
        Mat_patch   =  Average(i:end-par.patsize+i,j:end-par.patsize+j);
        Y(i,j,:,:)      =  tens2mat(E_patch, 3);
        N_Y(i,j,:,:)    =  tens2mat(N_patch, 3);
        Mat(i,j,:)    =  Mat_patch(:)';
    end
end
