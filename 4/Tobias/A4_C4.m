clear
clc
close all
addpath assignment4data\
load('A4_C2_variables.mat')

P = {P0,P_best};
lambda = 0.5;
Pnew = P;
Unew = Xmodel;

for i = 1:10
[r,J] = LinearizeReprojErr(Pnew,Xmodel,x);
C = J'*J+lambda*speye(size(J,2));
c = J'*r;
deltav = -C\c;
[Pnew,Unew] = update_solution(deltav,Pnew,Unew);
end