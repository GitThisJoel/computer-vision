clear
clc
close all
addpath assignment4data\
load('A4_C2_variables.mat')

P = {P0,P_best};
gammak = 0.75;
Pnew = P;
Unew = Xmodel;
[err , res]=ComputeReprojectionError(Pnew,Unew,x);
err0 = err;
for i = 1:10
[r,J] = LinearizeReprojErr(Pnew,Xmodel,x);
deltav = -gammak*J'*r;
[Pnew,Unew] = update_solution(deltav,Pnew,Unew);
[err1 , res]=ComputeReprojectionError(Pnew,Unew,x);
if err1>err0
gammak = gammak*0.50;
end
end

