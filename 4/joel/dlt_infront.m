function [P_best, X_best] = dlt_infront(P1, P2, x1, x2)
    infront = [0,0,0,0];
    X = {};
    for i=1:size(P2)
        for j=1:size(x1, 2)
            M = [P1 -x1(:,j) zeros(3,1);
                P2{i} zeros(3,1) -x2(:,j)];
            [U,S,V] = svd(M);
            v = V(:, end);
            X{i}(1:4, j) = v(1:4);
            
            d1 = depth(P1, v(1:4));
            d2 = depth(P2{i}, v(1:4));
            
            if sign(d1) > 0 & sign(d2) > 0 
                infront(i) = infront(i) + 1;
            end
        end
        X{i} = pflat(X{i});
    end
    [m,ind] = max(infront);
    P_best = P2{ind};
    X_best = X{ind};
end

