close all
clear 
clc
addpath assignment4data

load('compEx2data.mat')

im1 =imread('im1.jpg');
im2 = imread('im2.jpg');

x{1} = [x{1};ones(1,size(x{1},2))];
x{2} = [x{2};ones(1,size(x{2},2))];

%normalizing 
x1norm = K^-1*x{1};
x2norm = K^-1*x{2};

bestE =[];
inliers_best=0;

for i = 1:500
%choosing 5 random points
rand = randperm(size(x1norm,2),5);
rx1 = x1norm(:,rand);
rx2 = x2norm(:,rand);

%finding candidates for E
E = fivepoint_solver(rx1,rx2);


for k = 1:size(E,2)
%calculating the un-normalized fundamental matrix
F = inv(K)'*E{k}*inv(K);

%epipolar line in image 2
l2 = pflat(F*x{1});
%l2 = l2./sqrt(repmat(l2(1,:).^2 +l2(2,:).^2,[3 1]));

%epipolar line in image 1
l1 = pflat(F*x{2});
%l1 = l1./sqrt(repmat(l1(1,:).^2 +l1(2,:).^2,[3 1]));

%finding distance between lines and corresponding image point
d1 = abs(sum(l1.*x{1}))./hypot(l1(1),l1(2));
d2 = abs(sum(l2.*x{2}))./hypot(l2(2),l2(2));

% for j = 1:size(l1,2)
% d1(i) = d1(i)/hypot(l1(1,i),l1(2,i));
% d2(i) = d2(i)/hypot(l2(1,i),l2(2,i));
% end

%matches that are less than 5 pixels from the lines in both images
inliers = (d1<5)&(d2<5);

%only keeping if the solution is better (has more inliers)
if sum(inliers(:)==1)>sum(inliers_best(:)==1)
bestE = E{k};
inliers_best = inliers;
end


end

end
sum(inliers_best(:)==1)
P0 = [eye(3) zeros(3,1)];

%finding all the possible cameras from E
P = cameraE(bestE);

[P_best,Xmodel] = infront(P,x,x1norm,x2norm);

Xmodel = pflat(Xmodel);

figure()
plot3(Xmodel(1,:),Xmodel(2,:),Xmodel(3,:),'.','Markersize',2)
axis equal
hold on
plotcams({P_best,P0})

RMS1 = sqrt(1/size(x{1},2).*norm(P0*Xmodel-x{1})^2);
RMS2 = sqrt(1/size(x{2},2).*norm(P_best*Xmodel - x{2})^2);


save("A4_C2_variables",'P0','P_best','Xmodel','x');





