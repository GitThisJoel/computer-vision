function P = cameraE(E)
W = [0 -1 0;1 0 0; 0 0 1];
[U,S,V] = svd(E);

if det(U*V')>0
    E = U*diag([1 1 0])*V';
else
    V = -V;
    E = U*diag([1 1 0])*V';
end

P1 = [U*W*V' U(:,3)]; 
P2 = [U*W*V' -U(:,3)]; 
P3 = [U*W'*V' U(:,3)];
P4 = [U*W'*V' -U(:,3)];
P = {P1,P2,P3,P4};
end