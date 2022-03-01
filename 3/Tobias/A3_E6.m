clear
close all
clc


U = [1/sqrt(2) -1/sqrt(2) 0; 1/sqrt(2) 1/sqrt(2) 0; 0 0 1];
V = [1 0 0; 0 0 -1; 0 1 0];
W = [0 -1 0;1 0 0; 0 0 1];

P1 = [eye(3) zeros(3,1)];
P21 = [U*W*V' U(:,3)]; 
P22 = [U*W*V' -U(:,3)]; 
P23 = [U*W'*V' U(:,3)];
P24 = [U*W'*V' -U(:,3)];


s14 = -1/sqrt(2);
s23 = 1/sqrt(2);
X14 = [0 0 1 s14]';
X23 = [0 0 1 s23]';

d1 = depth(P1,X14);
d12 = depth(P21,X14);

d2 = depth(P1,X23);
d22 = depth(P22,X23);

d3 = d2;
d32 = depth(P23,X23);

d4 = d1;
d42 = depth(P24,X14);

D = [d1 d12 d2 d22 d3 d32 d4 d42];
index = 0;

for i = 1:2:size(D,2)-1
    if(sign(D(i))>0 & sign(D(i+1))>0)
    index = i;
    end
end
(index+1)/2 %finding the right pair of cameras
