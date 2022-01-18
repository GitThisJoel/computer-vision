function Esol = fivepoint_solver(x1n,x2n)
%Computes Essential matrices from the normalized image coordinates x1n and x2n
%x1n should be 3x5 where each column corresponds to a homogeneous point
%x2n shoudl have the same format.
M = zeros(5,9);
for i = 1:5;
    
    %Lägg till ekv
    xx = x1n(:,i)*x2n(:,i)';
    M(i,:) = xx(:)';
end

Evec = null(M);
E{1} = reshape(Evec(:,1),[3 3])';
E{2} = reshape(Evec(:,2),[3 3])';
E{3} = reshape(Evec(:,3),[3 3])';
E{4} = reshape(Evec(:,4),[3 3])';

% The constraint: 2*E*E'*E-trace(E*E')*E = 0
coeffs = zeros(9,64);
mons = zeros(4,64);
for i = 1:4
    for j = 1:4
        for k = 1:4
            mons(i,k+(j-1)*4+(i-1)*16) = mons(i,k+(j-1)*4+(i-1)*16)+1;
            mons(j,k+(j-1)*4+(i-1)*16) = mons(j,k+(j-1)*4+(i-1)*16)+1;
            mons(k,k+(j-1)*4+(i-1)*16) = mons(k,k+(j-1)*4+(i-1)*16)+1;

            new_coeffs = 2*E{i}*E{j}'*E{k}-trace(E{i}*E{j}')*E{k};
            coeffs(:,k+(j-1)*4+(i-1)*16) = new_coeffs(:);
        end
    end
end

% The determinant constraint
% e11*e22*e33+e12*e23*e31+e13*e21*e32-e11*e23*e32-e12*e21*e33-e13*e22*e31=0
det_coeffs = zeros(1,64);
for i = 1:4
    for j = 1:4
        for k = 1:4
            det_coeffs(k+(j-1)*4+(i-1)*16) = ...
            E{i}(1,1)*E{j}(2,2)*E{k}(3,3) ... %e11*e22*e33
            + E{i}(1,2)*E{j}(2,3)*E{k}(3,1) ... %e12*e23*e31
            + E{i}(1,3)*E{j}(2,1)*E{k}(3,2) ... %e13*e21*e32
            - E{i}(1,1)*E{j}(2,3)*E{k}(3,2) ... %e11*e23*e32
            - E{i}(1,2)*E{j}(2,1)*E{k}(3,3) ... %e12*e21*e33
            - E{i}(1,3)*E{j}(2,2)*E{k}(3,1);    %e13*e22*e31
        end
    end
end

coeffs = [coeffs; det_coeffs];

%Make monomials unique
[~,I,J] = unique(mons','rows');
mons = mons(:,I);
coeffs_small = zeros(10,length(I));
for i = 1:size(coeffs,1)
    coeffs_small(i,:) = accumarray(J,coeffs(i,:))';
end

%Set x_1 = 1;
mons = mons(2:4,:);

reduced_coeffs = rref(coeffs_small);

%construct action matrix multiplication with x_4
Mx4 = zeros(10,10);
mon_basis = mons(:,11:end);
for i = 1:size(mon_basis,2);
    x4mon = mon_basis(:,i)+[0;0;1];
    if sum(x4mon) >= 3; %degree >= 3, find and reduce
        row = find(sum(abs(mons(:,1:10)-x4mon*ones(1,10))) == 0);
        Mx4(:,i) = -reduced_coeffs(row,11:end)';
    else %degree <= 2 no reduction.
        ind = find(sum(abs(mon_basis-x4mon*ones(1,10))) == 0);
        Mx4(ind,i) = 1;
    end
end

%Extract real solutions
[V,D] = eig(Mx4');
V = V./repmat(V(end,:),[10 1]);

Esol = cell(0);
for i = 1:10
    if isreal(D(i,i))
        x2 = V(end-1,i);
        x3 = V(end-2,i);
        x4 = V(end-3,i);
        
        Esol{end+1} = E{1}+E{2}*x2+E{3}*x3+E{4}*x4;
    end
end


















if 0
    xtest = randn(3,1);
    Etest = E{1}+E{2}*xtest(1)+E{3}*xtest(2)+E{4}*xtest(3);
    %2*E*E'*E-trace(E*E')*E
    f1 = 2*Etest*Etest'*Etest-trace(Etest*Etest')*Etest;
    f2 = 0;
    for i = 1:length(mons);
        f2 = f2+ coeffs_small(1:9,i)*prod(xtest.^mons(:,i));
    end
    f1(:)-f2(:)
    
    %det(E)
    det(Etest)
    f2 = 0;
    for i = 1:length(mons);
        f2 = f2+ coeffs_small(10,i)*prod(xtest.^mons(:,i));
    end
    f2
end
