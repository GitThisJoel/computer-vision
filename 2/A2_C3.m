clear
close all
addpath("assignment2data\")
load("compEx3data.mat")
im1 = imread("cube1.jpg");
im2 = imread("cube2.jpg");

%calculate mean and standard deviation of the points in each picture
mean1 = mean(x{1}(1:2,:),2);
std1  = std(x{1}(1:2,:),0,2);
mean2 = mean(x{2}(1:2,:),2);
std2  = std(x{2}(1:2,:),0,2);

N1 = normMatrix(mean1,std1);
N2 = normMatrix(mean2,std2);

x1norm = N1*x{1};
x2norm = N2*x{2};

figure()
plot(x1norm(1,:),x1norm(2,:),'b*')
figure()
plot(x2norm(1,:),x2norm(2,:),'r*')


Xmodel = [Xmodel;ones(1,size(Xmodel,2))]; % adding a row of ones

rowcounter = 1;
colcounter = 13;
M1 = [zeros(3*size(Xmodel,2),3*size(Xmodel,1)+size(Xmodel,2))];
M2 = [zeros(3*size(Xmodel,2),3*size(Xmodel,1)+size(Xmodel,2))];
%creating the M matrix
for i=1:37
    m = [Xmodel(:,i)' zeros(1,8);
        zeros(1,4) Xmodel(:,i)' zeros(1,4);
        zeros(1,8) Xmodel(:,1)'];
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
norm(v1,2); %making sure that v has the length 1
norm(v2,2);
smallestEigen1 = S1(size(S1,2),end); %checking the smallest eigenvalue
smallestEigen2=S2(size(S2,2),end);
miniMize1 = norm(M1*v1,2); %making sure that the length is close to 0
miniMize2 = norm(M2*v2,2); 


P1 = [v1(1:4,1)';v1(5:8,1)';v1(9:12,1)'];
P2 = [v2(1:4,1)';v2(5:8,1)';v2(9:12,1)'];
[r1 q1] = rq(P1);
[r2 q2] = rq(P2);

cameraplot(inv(N1)*P1,im1,Xmodel,x,1); %ploting points projected by camera 1 into picture 1
cameraplot(inv(N2)*P2,im2,Xmodel,x,2); %ploting points projected by camera 2 into picture 2


function cameraplot(P,im,Xmodel,x,i)
projectx = pflat(P*Xmodel);
figure()
imagesc(im)
hold on
plot(projectx(1,:),projectx(2,:),'r*');
plot(x{i}(1,:),x{i}(2,:),'bo');
end

function f = normMatrix(mean,std)
f = [1/std(1) 0 -mean(1)/std(1);
    0 1/std(2) -mean(2)/std(2);
    0  0 1];
end