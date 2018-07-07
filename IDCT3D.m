function yx=IDCT3D(X)
% it is the implementation of Eq2 in the paper

N=size(X,1);
MYK=ones(1,N);
MYK(1)=1/sqrt(2);

for n1=0:N-1
    for n2=0:N-1
        for n3=0:N-1
            sm=0;
            for k1=0:N-1
                for k2=0:N-1
                    for k3=0:N-1
                        sm=sm+ MYK(k1+1)*MYK(k2+1)*MYK(k3+1)*X(k1+1,k2+1,k3+1)*...  
                            cos(pi/(2*N)*(2*n1+1)*k1)*cos(pi/(2*N)*(2*n2+1)*k2)*cos(pi/(2*N)*(2*n3+1)*k3);                        
                    end
                end
            end
            yx(n1+1,n2+1,n3+1)=sm;
        end
    end
end