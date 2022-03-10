function d = depth(P, X)
    X = pflat(X);
    A = P(:, 1:3);
    a = P(:, 4);
    
    d = zeros(1, size(X,2));
    for i=1:size(X,2)
        d(i) = (sign(det(A))/norm(A(:,3),2)) * [A(:,3)' a(3)] * X(:,i);
    end
end

