clear
close all
addpath("assignment2data\")
load("compEx3data.mat")

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
M=[];
x =[];

for i=1:37
    m = diag([Xmodel(:,i)' Xmodel(:,i)' Xmodel(:,i)']);
    M = [M;m];
end



function f = normMatrix(mean,std)
f = [1/std(1) 0 -mean(1)/std(1);
    0 1/std(2) -mean(2)/std(2);
    0  0 1];
end