function  [Init_Index]  =  Block_matching_my(X, Par,Neighbor_arr,Num_arr, SelfIndex_arr)
L         =   length(Num_arr);
Init_Index   =  zeros(Par.patnum,L);

for  i  =  1 : L
    Patch = X(:,:,SelfIndex_arr(i));
    Patch = Patch(:);
    Neighbors = tens2mat(X(:,:,Neighbor_arr(1:Num_arr(i),i)),3)';    
    Dist = sum((repmat(Patch,1,size(Neighbors,2))-Neighbors).^2);    
    [val, index] = sort(Dist);
    Init_Index(:,i)=Neighbor_arr(index(1:Par.patnum),i);
end
