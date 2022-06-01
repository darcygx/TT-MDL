function t = ttsvd_mdl(Y,R)
% refer to tt_tensor.m in TT-toolbox
%TT-MDL implemented by Xiao Gong
t=tt_tensor;
c=Y;
n = size(c);
d = numel(n);
r = ones(d+1,1);
core=[];
pos=1;
if isempty(R)
    for i=1:d-1
        m=n(i)*r(i);
        c=reshape(c,[m,numel(c)/m]);
        [U,S,V]=svd(c,'econ');
        S=diag(S);
        R(i) = MDL_my(c);  % estimate rank
        U=U(:,1:R(i)); S=S(1:R(i));
        r(i+1)=R(i);
        core(pos:pos+r(i)*n(i)*r(i+1)-1, 1)=U(:);
        V=V(:,1:R(i));
        V=V*diag(S); c=V';
        pos=pos+r(i)*n(i)*r(i+1);
    end
else
    for i=1:d-1
        m=n(i)*r(i);
        c=reshape(c,[m,numel(c)/m]);
        [U,S,V]=svd(c,'econ');
        S=diag(S);
        U=U(:,1:R(i)); S=S(1:R(i));
        r(i+1)=R(i);
        core(pos:pos+r(i)*n(i)*r(i+1)-1, 1)=U(:);
        V=V(:,1:R(i));
        V=V*diag(S); c=V';
        pos=pos+r(i)*n(i)*r(i+1);
    end
end
%             disp(['TT=',int2str(R)]);
core(pos:pos+r(d)*n(d)*r(d+1)-1)=c(:);
core=core(:);
ps=cumsum([1;n'.*r(1:d).*r(2:d+1)]);
t.d=d;
t.n=n;
t.r=r;
t.ps=ps;
t.core=core;
end
