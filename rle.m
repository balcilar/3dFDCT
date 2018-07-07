function data = rle(x,type)

if type==1 % decoding
    n=length(x);
    x1=x(1:n/2)';
    x2=x(n/2+1:end)';
	i = cumsum([ 1 x2 ]);
	j = zeros(1, i(end)-1);
	j(i(1:end-1)) = 1;
	data = x1(cumsum(j));
else % encoding
	if size(x,1) > size(x,2), x = x'; end % if x is a column vector, tronspose
    i = [ find(x(1:end-1) ~= x(2:end)) length(x) ];
	data2 = diff([ 0 i ]);
	data1 = x(i);
    data=[data1';data2'];
end