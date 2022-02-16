clear
close all
addpath assignment3data
load("A3_C3_variables.mat")
load("A3_C1_variables.mat")
load("compEx1data.mat")
load('compEx3data.mat')

im1 = imread("kronan1.jpg");
im2 = imread("kronan2.jpg");

x1norm=K^(-1)*x{1};
x2norm = K^(-1)*x{2};
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

P0 = K*P0;
P_best = K*P_best;
xproj2= pflat(P_best*X{index});
xproj1 = pflat(P0*X{index});
X{index} = pflat(X{index});


figure()
imagesc(im1)
hold on
plot(xproj1(1,:),xproj1(2,:),'r*');
plot(x{1}(1,:),x{1}(2,:),'bo');

figure()
imagesc(im2);
hold on
plot(xproj2(1,:),xproj2(2,:),'r*');
plot(x{2}(1,:),x{2}(2,:),'bo');


figure()
plot3(X{index}(1,:),X{index}(2,:),X{index}(3,:),'.','Markersize',2)
axis equal
hold on
plotcams({P_best,P0})

