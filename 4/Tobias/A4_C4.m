clear
clc
close all
addpath assignment4data\
load('A4_C2_variables.mat')


P = {P0,P_best};
lambda = 0.1;
%P0 = K^-1*P0;
Pnew = P;
%{K^-1*P_best,P0};
Unew = Xmodel;
%x{1} = K^-1*x{1};
%x{2} = K^-1*x{2};

[err1 , res]=ComputeReprojectionError(Pnew,Unew,x);
figure()
plot(0,sum(res),'r*')
hold on

for i = 1:10
[r,J] = LinearizeReprojErr(Pnew,Unew,x);
C = J'*J+lambda*speye(size(J,2));
c = J'*r;
deltav = -C\c;
[Pnew,Unew] = update_solution(deltav,Pnew,Unew);
[err , res]=ComputeReprojectionError(Pnew,Unew,x);
plot(i,sum(res),'r*')
end

RMS = sqrt(err/size(res,2))

%RMS(x{1},Pnew{1},Unew)
%RMS(x{2},Pnew{2},Unew)



%figure()
%plot3(Unew(1,:),Unew(2,:),Unew(3,:),'.','Markersize',2.5)
%axis equal
%hold on
%plotcams(Pnew)