A1 = [800/sqrt(2) 0 2400/sqrt(2)]';
A2 = [-700/sqrt(2) 1400 700/sqrt(2)]';
A3 = 1/sqrt(2) * [-1 0 1]';

f = norm(A3, 2);
R3 = f * 1/sqrt(2) * [-1 0 1]';

e = A2' * R3;

dR2 = A2 - e*R3;
d = norm(dR2,2);
R2 = dR2 ./ d;

c = A1'*R3;
b = A1'*R2;
aR1 = A1 - c*R3;
a = norm(aR1);
R1 = aR1 ./ a;

K = [a b c; 0 d e; 0 0 f];
R = [R1'; R2'; R3']