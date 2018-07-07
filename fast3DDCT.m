function X=fast3DDCT(x)
% implementtaion of fast 3d dct according to butterfly archnitecture
% 

N=size(x,1);
[k2 k1 k3]=meshgrid(0:N/2-1);

Sm=zeros(N/2,N/2,N/2,8);
for n1=0:N/2-1
    for n2=0:N/2-1
        for n3=0:N/2-1
            t1=pi/(2*N)*(4*n1+1);
            t2=pi/(2*N)*(4*n2+1);
            t3=pi/(2*N)*(4*n3+1);
            ci0=cos(t1*(2*k1));
            ci1=cos(t1*(2*k1+1));
            cj0=cos(t2*(2*k2));
            cj1=cos(t2*(2*k2+1));
            cl0=cos(t3*(2*k3));
            cl1=cos(t3*(2*k3+1));
            
            i=0;j=0;l=0;            
            % 8 butterfly operation are here
            Sm(:,:,:,1)=Sm(:,:,:,1)+xtildaijl(x,i,j,l,n1,n2,n3).*ci0.*cj0.*cl0;
            i=0;j=0;l=1;
            Sm(:,:,:,2)=Sm(:,:,:,2)+xtildaijl(x,i,j,l,n1,n2,n3).*ci0.*cj0.*cl1;
            i=0;j=1;l=0;
            Sm(:,:,:,3)=Sm(:,:,:,3)+xtildaijl(x,i,j,l,n1,n2,n3).*ci0.*cj1.*cl0;
            i=0;j=1;l=1;
            Sm(:,:,:,4)=Sm(:,:,:,4)+xtildaijl(x,i,j,l,n1,n2,n3).*ci0.*cj1.*cl1;
            i=1;j=0;l=0;
            Sm(:,:,:,5)=Sm(:,:,:,5)+xtildaijl(x,i,j,l,n1,n2,n3).*ci1.*cj0.*cl0;
            i=1;j=0;l=1;
            Sm(:,:,:,6)=Sm(:,:,:,6)+xtildaijl(x,i,j,l,n1,n2,n3).*ci1.*cj0.*cl1;
            i=1;j=1;l=0;
            Sm(:,:,:,7)=Sm(:,:,:,7)+xtildaijl(x,i,j,l,n1,n2,n3).*ci1.*cj1.*cl0;
            i=1;j=1;l=1;
            Sm(:,:,:,8)=Sm(:,:,:,8)+xtildaijl(x,i,j,l,n1,n2,n3).*ci1.*cj1.*cl1;
            
        end
    end
end
% post adding section.
i=0;j=0;l=0;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,1);%8/(N^3)*myK(k1)*myK(k2)*myK(k3)*sm;

i=0;j=0;l=1;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,2);

i=0;j=1;l=0;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,3);
i=0;j=1;l=1;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,4);
i=1;j=0;l=0;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,5);
i=1;j=0;l=1;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,6);
i=1;j=1;l=0;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,7);
i=1;j=1;l=1;
x1=2*k1(1,1,1)+i+1;
x2=2*k1(end,1,1)+i+1;
y1=2*k2(1,1,1)+j+1;
y2=2*k2(1,end,1)+j+1;
z1=2*k3(1,1,1)+l+1;
z2=2*k3(1,1,end)+l+1;

yyX(x1:2:x2,y1:2:y2,z1:2:z2)=Sm(:,:,:,8);
% multiplly by constant coefficient according to dct formula
[k2 k1 k3]=meshgrid(0:N-1);
Q=ones(N,N,N);
Q(k1==0)=Q(k1==0)/sqrt(2);
Q(k2==0)=Q(k2==0)/sqrt(2);
Q(k3==0)=Q(k3==0)/sqrt(2);

X=yyX.*Q.*8/(N^3);



