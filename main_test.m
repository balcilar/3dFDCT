clear all
clc

% define N for time compuming test
N=32;

% generate NxNxN gaussian random input
x=rand(N,N,N);

% perform ordinary 3d DCT and measure time
tic
X=DCT3D(x);
t1=toc;


% perform fast3D DCT and measure time
tic
yyX=fast3DDCT(x);
t2=toc;

% report result
fprintf('Time conpumstion for %dx%dx%d matrix DCT with ordinary alg :%g sec\n',N,N,N,t1);
fprintf('Time conpumstion for %dx%dx%d matrix DCT with fast alg :%g sec\n',N,N,N,t2);

diff=sum(sum(sum(abs(X-yyX))));
fprintf('difference between fast and ordinary ones output: %g \n' ,diff);















