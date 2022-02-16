clear
close all
addpath assignment3data

load('compEx1data.mat');
load('A3_C1_variables.mat') %loading the fundamental matrix and normalization matrices from C1
im1 = imread("kronan1.jpg");
im2 = imread("kronan2.jpg");

P1 = [eye(3) zeros(3,1)];
F = F_tilde;

e2 = null(F');  
e2x = [0 -e2(3) e2(2); e2(3) 0 -e2(1);-e2(2) e2(1) 0];

P2 = [e2x*F e2];

x1norm = N1*x{1};
x2norm = N2*x{2};

X=[];
%solving the triangulation problem with DLT
for i=1:size(x1norm,2)
M = [[P1 -x1norm(:,i) zeros(3,1)];
    [P2 zeros(3,1) -x2norm(:,i)]];
[U,S,V] = svd(M);
v = V(:,end);
X=[X v(1:4,1)];
end
P2 = inv(N2)*P2;
P1 = inv(N1)*P1;


d = depth(P1,X);

if(sign(max(d))~=sign(min(d)))
%adjusting the solution to become QA
temp = X(3,:);
X(3,:) = X(4,:);
X(4,:) = temp;
X = pflat(X);

P1=QuasiCamera(P1);
P2 = QuasiCamera(P2);
end



xproj2 =pflat(P2*X);
xproj1 = pflat(P1*X);

figure()
imagesc(im2);
hold on
plot(xproj2(1,:),xproj2(2,:),'r*');
plot(x{2}(1,:),x{2}(2,:),'bo');

figure()
imagesc(im1);
hold on
plot(xproj1(1,:),xproj1(2,:),'r*');
plot(x{1}(1,:),x{1}(2,:),'bo');


figure()
plot3(X(1,:),X(2,:),X(3,:),'.','Markersize',2)
axis equal

function f=QuasiCamera(P) 
temp=P(:,3);
P(:,3) = P(:,4);
P(:,4) = temp;
f = P;
end



