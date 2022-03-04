clear 

U = [1/sqrt(2) -1/sqrt(2) 0; 1/sqrt(2) 1/sqrt(2) 0; 0 0 1];
V = [1 0 0; 0 0 -1; 0 1 0];
E = U*diag([1 1 0])*V';

x1 = [0 0 1]';
x2 = [1 1 1]';
x2'*E*x1; 

u3 = [0 0 1]';
W = [0 -1 0; 1 0 0; 0 0 1];

P1 = [eye(3,3) zeros(3,1)];

P2_1 = [U*W*V'   u3];
P2_2 = [U*W*V'  -u3];
P2_3 = [U*W'*V'  u3];
P2_4 = [U*W'*V' -u3];

s1 = -1/sqrt(2);
s2 = 1/sqrt(2);
s3 = s2;
s4 = s1;

X = [0 0 1 s1]';

d1_1 = depth(P1, [0 0 1 s1]');
d1_2 = depth(P1, [0 0 1 s2]');
d1_3 = depth(P1, [0 0 1 s3]');
d1_4 = depth(P1, [0 0 1 s4]');

d2_1 = depth(P2_1, [0 0 1 s1]');
d2_2 = depth(P2_2, [0 0 1 s2]');
d2_3 = depth(P2_3, [0 0 1 s3]'); % > 0 
d2_4 = depth(P2_4, [0 0 1 s4]'); % > 0

if d1_1 > 0 & d2_1 > 0
    disp("first pair is ok");
end 

if d1_2 > 0 & d2_2 > 0
    disp("second pair is ok");
end 

if d1_3 > 0 & d2_3 > 0
    disp("third pair is ok");
end 

if d1_4 > 0 & d2_4 > 0
    disp("forth pair is ok");
end 

function d = depth(P, X)
    X = pflat(X);
    A = P(:, 1:3);
    a = P(:,4);
    d = (sign(det(A))/norm(A(:,3),2)) * [A(:,3)' a(3)] * X;
end 
