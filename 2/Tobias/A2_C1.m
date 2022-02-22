clear all
close all

addpath assignment2data
load("compEx1data.mat")

im = imread(imfiles{1});

figure()
hold on
plot3(X(1,:),X(2,:),X(3,:),'b.','Markersize',2); %plots the 3D points of reconstruction
plotcams(P) %plot the cameras
axis equal

imageplot(1,imfiles,X,P,x);

%projective transformations 
T1 = [1 0 0 0;0 4 0 0; 0 0 1 0; 0.1 0.1 0 1];
T2 = [1 0 0 0 ; 0 1 0 0; 0 0 1 0; 1/16 1/16 0 1];

X1 = pflat(T1*X); %new projective solution
X2 = pflat(T2*X);
P1 = P;
P2 = P;
for i=1:9
P1{i} = P{i}*inv(T1); % new cameras
P2{i} = P{i}*inv(T2);
end
%Plots of new solutions
figure()
hold on
plot3(X1(1,:),X1(2,:),X1(3,:),'b.','Markersize',2);
plotcams(P1);
axis equal
% 
% figure()
% hold on
% plot3(X2(1,:),X2(2,:),X2(3,:),'b.','Markersize',2);
% plotcams(P2);

axis equal

%projecting and plotting the points in the images
imageplot(1,imfiles,X1,P1,x)

imageplot(1,imfiles,X2,P2,x)

%%computer exercise 2

[k1 r1] = rq(P1{1}(:,1:3));
[k2 r2] = rq(P2{1}(:,1:3));

% i = the number of image
%files = the file with the images
%X = matrix containing the homogenous coordinates for all 3D points
%P = the camera matrix
%x = image points
function imageplot(i,files,X,P,x)
figure()
hold on
im = imread(files{i}); % reading image
imagesc(im);
visible = isfinite(x{i}(1,:)); %determining visible points
xproj = pflat(P{1}*X); % projecting the 3D points into the image
plot(x{i}(1,visible),x{1}(2,visible),'b*'); %plot of visible homogenous coordinates
plot(xproj(1,visible),xproj(2,visible),'ro') % plot of projected points
end




