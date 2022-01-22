X1 = [1 2 3 1]';
X2 = [1 1 1 1]';
X3 = [1 1 -1 1]';

P = [1 0 0 0; 
    0 1 0 0;
    0 0 1 1];

viewDirec = P(3,1:3)

p1 = pflat(P*X1)
p2 = pflat(P*X2)
p3 = pflat(P*X3)


center = pflat(null(P))

