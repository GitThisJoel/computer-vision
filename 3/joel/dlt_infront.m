function [P2_best, X_best] = dlt_infront(P1, P2s, x1_norm, x2_norm)
    nbr_infront = zeros(1,size(P2s,2));
    X = cell(1,4);

    for i=1:size(P2s,2)
        P2 = P2s{i};
        xs = zeros(size(P2s,2), size(x1_norm, 2));
        for j=1:size(x1_norm, 2)
            M = [P1 -x1_norm(:,j) zeros(3,1);
                P2 zeros(3,1) -x2_norm(:,j)];
            [~, ~, V] = svd(M);
            v = V(:, end);
            xs(:,j) = v(1:4);
            
            d1 = depth(P1, v(1:4));
            d2 = depth(P2, v(1:4));

            if sign(d1) > 0 && sign(d2) > 0
                nbr_infront(i) = nbr_infront(i) + 1;
            end 
        end
        X{i} = xs;
    end
    % best camera with max infront
    [~, ind] = max(nbr_infront);
    P2_best = P2s{ind};
    X_best = X{ind};
end

