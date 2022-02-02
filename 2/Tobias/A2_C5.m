clear
close all
load('C3_variables.mat'); %loading of cameras from C3
load('C4_variables.mat'); %loading of SIFT-points
im1 = imread("cube1.jpg");
im2 = imread("cube2.jpg");

%r1 = eye(size(r1));
%r2 = eye(size(r2));

x1 = pflat(inv(r1)*[x1;ones(1,size(x1,2))]); %normalizing SIFT points
x2 = pflat(inv(r2)*[x2;ones(1,size(x1,2))]);
P1 = inv(r1)*P1; %normalizing cameras
P2 = inv(r2)*P2;

X=[];
%solving the triangulation problem by with DLT
for i=1:size(x1,2)
M = [[P1 -x1(:,i) zeros(3,1)];
    [P2 zeros(3,1) -x2(:,i)]];
[U,S,V] = svd(M);
v = V(:,end);
X=[X v(1:4,1)];
end
X = pflat(X);
P1 = r1*P1; %"restoring" the cameras
P2 = r2*P2;
xproj1 = pflat(P1*X); %projecting the calculated points into the images
xproj2 = pflat(P2*X);

x1 = pflat(r1*x1);
x2 = pflat(r2*x2);

%plotting both measured and projected points
comparePlot(xproj1,x1,im1)
comparePlot(xproj2,x2,im2)


%finding the points where the difference is less than 3 pixels 
good_points = (sqrt(sum((x1(1:2,:)-xproj1(1:2,:)).^2))<3 & ...
    sqrt(sum((x2(1:2,:)-xproj2(1:2,:)).^2))<3);
X = X(:,good_points);

figure()
%plot of of the cube model with lines
plot3([Xmodel(1,startind);Xmodel(1,endind)],...
    [Xmodel(2,startind);Xmodel(2,endind)],...
    [Xmodel(3,startind);Xmodel(3,endind)],'b-');
hold on
%plot of the "good" points
plot3(X(1,:),X(2,:),X(3,:),'r.');
%plot of the cameras
plotcams({P1,P2})


function comparePlot(xproj, x,im)
figure()
imagesc(im)
hold on
plot(xproj(1,:),xproj(2,:),'r*')
plot(x(1,:),x(2,:),'co')
end