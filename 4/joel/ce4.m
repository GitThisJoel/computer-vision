clear
close all

addpath('../assignment4data')
load('ce2_variables.mat')

gammak = 10^-10;
lambda = 0.1;

% Takes two camera matrices and puts them in a cell.
P = {P1,P2};

U = X;
u = x;

% Computes the reprejection error and the values of all the residuals
% for the current solution P,U,u.
[err,res] = ComputeReprojectionError(P,U,u);

Pnew = P;
Unew = U;

figure();
plot(0, sum(res), 'r*')
hold on
for i=1:10
    % Computes the r and J matrices for the appoximate linear least squares problem .
    [r,J] = LinearizeReprojErr(Pnew,Unew,u);
    
    % Computes the LM update.
    % deltav = -gammak*J'*r;
    C = J'*J + lambda*speye(size(J,2));
    c = J'*r;
    deltav = -C\c;
    
    % Updates the variabels
    [Pnew, Unew] = update_solution(deltav,Pnew,Unew);
    
    [err,res] = ComputeReprojectionError(Pnew,Unew,u);
    
    plot(i, sum(res), 'r*')
end 
RMS = sqrt(err/size(res,2))