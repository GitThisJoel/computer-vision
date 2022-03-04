function l = dlt_infront(P, x1, x2)
    
    X = [];
    for i=1:size(x1, 2)
        M = [P1 -x1(:,i) zeros(3,1);
            P2 zeros(3,1) -x2(:,i)];
        [U,S,V] = svd(M);
        v = V(:, end);
        X = [X v(1:4)]; %length of X = (x y z w)
    end
    X = pflat(X);
    
end

