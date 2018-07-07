function yk=myK(x)
yk=ones(size(x));
yk(x==0)=1/sqrt(2);