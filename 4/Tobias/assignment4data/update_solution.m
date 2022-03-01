function [Pnew,Unew] = update_solution(deltav,P,U)
%Computes a new solution Pnew,Unew, from the old solution P,U and the 
%variable deltav

Ba = [0 1 0; -1 0 0; 0 0 0];
Bb = [0 0 1; 0 0 0; -1 0 0];
Bc = [0 0 0; 0 0 1; 0 -1 0];

dpointvar = [0; deltav(1:(3*size(U,2)-1))];
dpointvar = reshape(dpointvar, size(U(1:3,:)));
dcamvar = [0;0;0;0;0;0;deltav(3*size(U,2):end)];
dcamvar = reshape(dcamvar,[6 length(P)]);

Unew = pextend(U(1:3,:) + dpointvar);

Pnew = cell(size(P));
for i=1:length(P);
    KR0 = P{i}(:,1:3);
    t0 = P{i}(:,4);
    KR = KR0*expm(Ba*dcamvar(1,i) + Bb*dcamvar(2,i) + Bc*dcamvar(3,i));
    t = t0 + dcamvar(4:6,i);
    Pnew{i} = [KR t];
end

function Y = pextend(X)
Y = [X; ones(1,size(X,2))];