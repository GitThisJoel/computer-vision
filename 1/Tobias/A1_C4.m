clear all
close all
Im1 = imread('compEx4im1.JPG');
Im2 = imread('compEx4im2.JPG');
load('compEx4.mat');



P1 = K*[R1 t1];
P2 = K*[R2 t2];

%finding cameracenters 
center1 = pflat(null(P1));
center2 = pflat(null(P2));

%finding the viewdirections 
viewDirec1 = P1(3,1:3);
viewDirec2 = P2(3,1:3);
plotU = pflat(U);

figure(3)
hold on
plot3(center1(1,1),center1(2,1),center1(3,1),'r*') %plot center of camera 1
plot3(center2(1,1),center2(2,1),center2(3,1),'g*')%plot center of camera 2
plot3(plotU(1,:),plotU(2,:),plotU(3,:),'.','MarkerSize',2) %plot all the points in U
%plot a vector in the viewingdirection of camera 1
quiver3(center1(1),center1(2),center1(3),viewDirec1(1),viewDirec1(2),viewDirec1(3),10)
%plot a vector in the viewingdirection of camera 2
quiver3(center2(1),center2(2),center2(3),viewDirec2(1),viewDirec2(2),viewDirec2(3),10)

%transformation of U in camera 1 and 2
U1 = pflat(P1*U);
U2 = pflat(P2*U);

%plot of the transformations together with the images
figure(1)
imagesc(Im1)
colormap gray
hold on
plot(U1(1,:),U1(2,:),'.','MarkerSize',2)


figure(2)
imagesc(Im2)
colormap gray
hold on
plot(U2(1,:),U2(2,:),'.','MarkerSize',2)




