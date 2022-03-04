function [Pnew,Unew] = ComputeStr(d,P,U)
Ba = [0 1 0; -1 0 0; 0 0 0];
Bb = [0 0 1; 0 0 0; -1 0 0];
Bc = [0 0 0; 0 0 1; 0 -1 0];

dpointvar = [0; d(1:(3*size(U,2)-1))];
dpointvar = reshape(dpointvar, size(U(1:3,:)));
dcamvar = [0;0;0;0;0;0;d(3*size(U,2):end)];
dcamvar = reshape(dcamvar,[6 length(P)]);

Unew = pextend(U(1:3,:) + dpointvar);

Pnew = cell(size(P));
for i=1:length(P);
    R0 = P{i}(:,1:3);
    t0 = P{i}(:,4);
    R = expm(Ba*dcamvar(1,i) + Bb*dcamvar(2,i) + Bc*dcamvar(3,i))*R0;
    t = t0 + dcamvar(4:6,i);
    Pnew{i} = [R t];
end

function Y = pextend(X)
Y = [X; ones(1,size(X,2))];