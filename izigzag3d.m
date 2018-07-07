function matrix = izigzag3d(vector)
D = 3; % Dimensions
N = length(vector)^(1/D); % Number of characters, or cube side
N = round(N);
T = (N-1)*D+1;
% First column:
Vc = [ 1:N N-1:-1:1 ]; lVc = length(Vc);
Vs = 1:1:N;
for t = 1:T
 % First column:
 if t <= N,
 Lic(T-t+1) = 1;
 else
 Lic(T-t+1) = t-N+1;
 end
 if t <= N,
 Lsc(t) = lVc;
 else
 Lsc(t) = lVc-t+N;
 end
 if t <= T-(N-1),
 Lis(t) = 1;
 else
 Lis(t) = t-(T-N);
 end
 if t <= N,
 Lss(t) = t;
 else
 Lss(t) = N;
 end
end
% First column:
Wc = [];
Ws = [];
% Second column:
Av = [ 1:N N*ones(1,N-2) N:-1:1 ];
Ci = [ ones(1,N-1) 1:N ]; lCi = length(Ci);
Cd = [ 1:N N*ones(1,N-1) ];
d = 1;
Ci2 = [];
Cd2 = [];
Sig = [];
for t = 1:T
 if rem(t,2) == 0,
 % First column:
 Hc = Vc(Lic(t):Lsc(t));
 Wc = [ Wc Hc ];
 Hs = Vs(Lis(t):Lss(t)); 
 Ws = [ Ws Hs ];
 % Second column:
 if t <= N,
 Ci2 = [ Ci2 rot90(rot90(Ci(d:d+Av(t)-1))) ];
 Cd2 = [ Cd2 rot90(rot90(Cd(d:d+Av(t)-1))) ];
 else
 d = d+1;
 Ci2 = [ Ci2 rot90(rot90(Ci(d:d+Av(t)-1))) ];
 Cd2 = [ Cd2 rot90(rot90(Cd(d:d+Av(t)-1))) ];
 end
 else
 % First column:
 Hc = rot90(rot90(Vc(Lic(t):Lsc(t))));
 Wc = [ Wc Hc ];
 Hs = rot90(rot90(Vs(Lis(t):Lss(t))));
 Ws = [ Ws Hs ];
 % Second column:
 if t <= N,
 Ci2 = [ Ci2 Ci(d:d+Av(t)-1)];
 Cd2 = [ Cd2 Cd(d:d+Av(t)-1)];
 else
 d = d+1;
 Ci2 = [ Ci2 Ci(d:d+Av(t)-1)];
 Cd2 = [ Cd2 Cd(d:d+Av(t)-1)];
 end
 end
 % Second column:
 Sig = [ Sig (-1)^t*ones(1,Av(t)) ];
end
L = length(Ws);
W = [];
X = [];
Z = [];
for l = 1:L
 % First column:
 W = [ W Ws(l)*ones(1,Wc(l)) ];
 % Second column:
 if Sig(l) > 0,
 X = [ X Ci2(l):Cd2(l) ];
 Z = [ Z Cd2(l):-1:Ci2(l) ];
 else
 X = [ X Cd2(l):-1:Ci2(l) ];
 Z = [ Z Ci2(l):Cd2(l) ];
 end
end
LL = length(W);
for ll = 1:LL
 matrix(W(ll),X(ll),Z(ll)) = vector(ll);
end 