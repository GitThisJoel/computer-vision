function [a,b] = infront(P,x,x1norm,x2norm);
P0 = [eye(3) zeros(3,1)];
infront = zeros(size(P,2));
X =[];

for i = 1:4
    for j = 1:size(x{1},2)
    M = [P0 -x1norm(:,j) zeros(3,1);
    P{i} zeros(3,1) -x2norm(:,j)];
    [U,S,V] = svd(M);
    v = V(:,end);
    X{i}(1:4,j)=v(1:4,1);
    d0 = depth(P0,v(1:4,1));
    d1 = depth(P{i},v(1:4,1));
        if sign(d0)>0 & sign(d1)>0
        infront(i) = infront(i)+1;
        end 
    end

end
[m,index]=max(infront);
a =P{index};
b = X{index};


end