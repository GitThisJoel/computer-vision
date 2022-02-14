clear
close all
addpath assignment3data
load("A3_C3_variables.mat")
load("A3_C1_variables.mat")
load("compEx1data.mat")
im1 = imread("kronan1.jpg");
im2 = imread("kronan2.jpg");

x1norm=N1*x{2};
x2norm = N2*x{2};
W = [0 -1 0;1 0 0; 0 0 1];
[U,S,V] = svd(E);

if det(U*V')>0
    E = U*diag([1 1 0])*V';
else
    V = -V;
    E = U*diag([1 1 0])*V';
end

P0 = [eye(3) zeros(3,1)];
P1 = [U*W*V' U(:,3)]; 
P2 = [U*W*V' -U(:,3)]; 
P3 = [U*W'*V' U(:,3)];
P4 = [U*W'*V' -U(:,3)];

P = {P1,P2,P3,P4};
infront = [0,0,0,0];
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
        if sign(d0) & sign(d1)>0
        infront(i) = infront(i)+1;
        end 
    end

end
[m,index]=max(infront);
P_best = P{index};

P0 = inv(N1)*P0;
P_best = inv(N2)*P_best;
X{index}=pflat(X{index});
xproj2= P_best*X{index};

figure()
imagesc(im2);
hold on
plot(xproj2(1,:),xproj2(2,:),'r*');
plot(x{2}(1,:),x{2}(2,:),'bo');

figure()
plot3(X{index}(1,:),X{index}(2,:),X{index}(3,:),'.','Markersize',2)
axis equal

