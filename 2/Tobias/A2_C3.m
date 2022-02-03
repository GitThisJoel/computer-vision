clear
close all
addpath("assignment2data\")
load("compEx3data.mat")
im1 = imread("cube1.jpg");
im2 = imread("cube2.jpg");


%creating the transformation N
N1 = normMatrix(x{1});
N2 = normMatrix(x{2});

%normalizing the measured points
x1norm = N1*x{1};
x2norm = N2*x{2};

%plot of normalized points 
figure()
plot(x1norm(1,:),x1norm(2,:),'b*')
figure()
plot(x2norm(1,:),x2norm(2,:),'r*')


Xmodel = [Xmodel;ones(1,size(Xmodel,2))]; % adding a row of ones

rowcounter = 1;
colcounter = 13;
M1 = zeros(3*size(Xmodel,2),3*size(Xmodel,1)+size(Xmodel,2));
M2 = zeros(3*size(Xmodel,2),3*size(Xmodel,1)+size(Xmodel,2));
%creating the M matrix
for i=1:37
    m = [Xmodel(:,i)' zeros(1,8);
        zeros(1,4) Xmodel(:,i)' zeros(1,4);
        zeros(1,8) Xmodel(:,i)'];
    M1(rowcounter:rowcounter+2,1:12) = m;
    M2(rowcounter:rowcounter+2,1:12) = m;

    M1(rowcounter:rowcounter+2,colcounter) = -x1norm(:,i);
    M2(rowcounter:rowcounter+2,colcounter) = -x2norm(:,i);
    rowcounter = rowcounter+3;
    colcounter = colcounter+1;
end
% single value decomposition of M
[U1,S1,V1] = svd(M1);
[U2,S2,V2] = svd(M2);

v1 = V1(:,end); % finding the solution
v2 = V2(:,end);
norm(v1,2); %checking if v has the length 1
norm(v2,2);
smallestEigen1 = S1(size(S1,2),end); %checking the smallest eigenvalue
smallestEigen2=S2(size(S2,2),end);
miniMize1 = norm(M1*v1,2); %making sure that the length is close to 0
miniMize2 = norm(M2*v2,2); 

%finding the cameras
P_tilde1 = [v1(1:4,1)';v1(5:8,1)';v1(9:12,1)'];
P_tilde2 = [v2(1:4,1)';v2(5:8,1)';v2(9:12,1)'];

%calculating the original camera
P1 = inv(N1)*P_tilde1;
P2 = inv(N2)*P_tilde2;
%finding the camera parameters
[r1,q1] = rq(P1);
[r2,q2] = rq(P2);
r1 = r1./r1(3,3);
r2 = r2./r2(3,3);


cameraplot(P1,im1,Xmodel,x,1); %ploting points projected by camera 1 into picture 1
cameraplot(P2,im2,Xmodel,x,2); %ploting points projected by camera 2 into picture 2
figure()
plot3(Xmodel(1,:),Xmodel(2,:),Xmodel(3,:),'b.');
hold on
plotcams({P1,P2});
save('C3_variables','P1','P2','startind','endind','Xmodel','r1','r2');

function cameraplot(P,im,Xmodel,x,i)
projectx = pflat(P*Xmodel);
figure()
imagesc(im)
hold on
plot(projectx(1,:),projectx(2,:),'r*');
plot(x{i}(1,:),x{i}(2,:),'co');
end
function f = normMatrix(x)
m = mean(x(1:2,:),2);
s  = std(x(1:2,:),0,2);
f = [1/s(1) 0 -m(1)/s(1);
    0 1/s(2) -m(2)/s(2);
    0  0 1];
end