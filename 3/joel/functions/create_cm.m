function P = create_cm(E)
    W = [0 -1 0; 1 0 0; 0 0 1];
    [U, ~, V] = svd(E);
    
    if det(U*V') <= 0
        V = -V;
    end 
    
    u3 = U(:,3);
    
    P2_1 = [U*W*V'   u3];
    P2_2 = [U*W*V'  -u3];
    P2_3 = [U*W'*V'  u3];
    P2_4 = [U*W'*V' -u3];
    P = {P2_1, P2_2, P2_3, P2_4};
end

