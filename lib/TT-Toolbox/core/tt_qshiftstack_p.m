function [tt]=tt_qshiftstack_p(d)

% returns a stack P of periodic shift matrices
% in the QTT format
%
% The size of the shift matrices matrices is N x N
% and the output is an N x N x N-tensor,
% where N=2^d(1) x ... x 2^d(end) 
%
% April 20, 2011
% Vladimir Kazeev
% vladimir.kazeev@gmail.com
% INM RAS
% Moscow, Russia
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For details please see the preprint
% http://www.mis.mpg.de/publications/preprints/2011/prepr2011-36.html
% Vladimir A. Kazeev, Boris N. Khoromskij and Eugene E. Tyrtyshnikov
% Multilevel Toeplitz matrices generated by QTT tensor-structured vectors and convolution with logarithmic complexity
% January 12, 2012
% Vladimir Kazeev,
% Seminar for Applied Mathematics, ETH Zurich
% vladimir.kazeev@sam.math.ethz.ch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I=eye(2);
J=[0,1;0,0];
O=zeros(2);
P=J+J';

D=numel(d);
tt=cell(sum(d),1);
ind=0;
for K=1:D
	tt{ind+1}(:,:,1)=[I,P];
	tt{ind+1}(:,:,2)=[P,I];
	tt{ind+1}=permute(reshape(tt{ind+1},[2,2,2,2]),[1,2,4,3]);
	tt{ind+1}=permute(tt{ind+1},[1,2,3,5,4]);
	
	for k=2:d(K)-1
		tt{ind+k}(:,:,1)=[I,J';O,J];
		tt{ind+k}(:,:,2)=[J',O;J,I];
		tt{ind+k}=permute(reshape(tt{ind+k},[2,2,2,2,2]),[1,3,5,2,4]);
	end

	tt{ind+d(K)}(:,:,1)=[I;O];
	tt{ind+d(K)}(:,:,2)=[J';J];
	tt{ind+d(K)}=permute(reshape(tt{ind+d(K)},[2,2,2,2]),[1,3,4,2]);
	
	ind=ind+d(K);
end

tt{1}=permute(tt{1},[1,2,3,5,4]);

tt=tt_reverse(tt,3);

return
end
