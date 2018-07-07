function y=xtilda(x,n1,n2,n3)
% this dunction gives the x(n1,n2,n3) after reordering step.

N=size(x,1);
ii=2*n1;
jj=2*n2;
kk=2*n3;
if n1>=N/2
    ii=2*N-2*n1-1;
end
if n2>=N/2
    jj=2*N-2*n2-1;
end
if n3>=N/2
    kk=2*N-2*n3-1;
end
y=x(ii+1,jj+1,kk+1);
% y=x(n1+1,n2+1,n3+1);
