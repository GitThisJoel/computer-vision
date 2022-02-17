close all
clear 
clc
addpath assignment4data
addpath("vlfeat-0.9.21\toolbox");
vl_setup;

a = imread('a.jpg');
b = imread('b.jpg');
subplot(2,1,1)
imagesc(a)
hold on
subplot(2,1,2)
imagesc(b)
%measuring points in both images
[fa da] = vl_sift(single(rgb2gray(a)));
[fb db] = vl_sift(single(rgb2gray(b)));

%finding and choosing matching points
matches = vl_ubcmatch(da,db);
xA = [fa(1:2,matches(1,:));ones(1,size(matches,2))];
xB =[fb(1:2,matches(2,:));ones(1,size(matches,2))];

H_best = [];
inliers_best = [];

for i = 1:30
    %chosing 4 random matching points
rand = randperm(size(matches,2),4);
rA = xA(:,rand);
rB = xB(:,rand);
rowcounter = 1;
colcounter = 10;
%creating the M matrix
M = zeros(3*size(rA,2),3*size(rA,1)+size(rA,2));
for j = 1:size(rA,2)
m = [rA(:,j)' zeros(1,6);
    zeros(1,3) rA(:,j)' zeros(1,3);
    zeros(1,6) rA(:,j)'];
  M(rowcounter:rowcounter+2,1:9) = m;
  M(rowcounter:rowcounter+2,colcounter) = -rB(:,j);
   rowcounter = rowcounter+3;
   colcounter = colcounter+1;
end
%finding H by svd
[U,S,V] = svd(M);
v = V(:,end);
H = [v(1:3)';v(4:6)';v(7:9)'];
transformedA=zeros(3,size(xA,2));
%transforming all matching points in a to points in b
for k = 1:size(xA,2)
transformedA(:,k)=pflat(H*xA(:,k));
end
%checking how many points that end up <5 pixels from the measured points in
%b
inliers = sqrt(sum((transformedA(1:2,:)-xB(1:2,:)).^2))<5;
%only saving the best solution
if sum(inliers(:)==1)>sum(inliers_best(:)==1)
H_best = H;
inliers_best = inliers;
end

end
%checking how many inliers we found
sum(inliers_best(:)==1)

%creating the panorama
Htform = projective2d(H_best');
Rout = imref2d(size(a),[-200 800],[-400,600]);
[Atransf] = imwarp(a,Htform,'OutputView',Rout);
Idtform=projective2d(eye(3));
[Btransf] = imwarp(b,Idtform,'Outputview',Rout);

AB = Btransf;
AB(Btransf<Atransf) = Atransf(Btransf<Atransf);

figure()
imagesc(Rout.XWorldLimits,Rout.YWorldLimits,AB)

