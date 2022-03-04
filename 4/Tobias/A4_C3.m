clear
clc
close all
addpath assignment4data\
load('A4_C2_variables.mat')

P = {P0,P_best};


gammak = 10^-10;
Pnew = P;
Unew = Xmodel;
[err1 , res]= ComputeReprojectionError(Pnew,Unew,x);

figure()
plot(0,sum(res),'r*')
hold on
for i = 1:10
[r,J] = LinearizeReprojErr(Pnew,Unew,x);
deltav = -gammak*J'*r;
[Pnew,Unew] = update_solution(deltav,Pnew,Unew);
[err , res]=ComputeReprojectionError(Pnew,Unew,x);
plot(i,sum(res),'r*');
end

RMS = sqrt(err/size(res,2))
%Not necessary
%RMS_1=RMS(x{1},Pnew{1},Unew)
%RMS_2=RMS(x{2},Pnew{2},Unew)

% figure()
% plot3(Unew(1,:),Unew(2,:),Unew(3,:),'.','Markersize',2.5)
% axis equal
% hold on
% plotcams(Pnew);
