clear all
close all

load('compEx3.mat')

H0 = [sqrt(3) -1 1;1 sqrt(3) 1; 0 0 1];
H1 = [sqrt(3) -1 1;1 sqrt(3) 1; 0 0 2];
H2 = [1 -1 1;1 1 0; 0 0 1];
H3 = [1 1 0; 0 2 0; 0 0 1];
H4 = [sqrt(3) -1 1; 1 sqrt(3) 1; 1/4 1/2 2];


transStart0 = pflat(H0*[startpoints; ones(1,42)]);
transEnd0 = pflat(H0*[endpoints;ones(1,42)]);

transStart1 = pflat(H1*[startpoints; ones(1,42)]);
transEnd1 = pflat(H1*[endpoints;ones(1,42)]);

transStart2 = pflat(H2*[startpoints; ones(1,42)]);
transEnd2 = pflat(H2*[endpoints;ones(1,42)]);

transStart3 = pflat(H3*[startpoints; ones(1,42)]);
transEnd3 = pflat(H3*[endpoints;ones(1,42)]);

transStart4 = pflat(H4*[startpoints; ones(1,42)]);
transEnd4 = pflat(H4*[endpoints;ones(1,42)]);

axis equal
figure(1)
hold on
plot([transStart1(1,:);transEnd1(1,:)],[transStart1(2,:);transEnd1(2,:)],'b-')
plot([transStart0(1,:);transEnd0(1,:)],[transStart0(2,:);transEnd0(2,:)],'r-')

figure(2)
plot([transStart2(1,:);transEnd2(1,:)],[transStart2(2,:);transEnd2(2,:)],'b-')

figure(3)
plot([transStart3(1,:);transEnd3(1,:)],[transStart3(2,:);transEnd3(2,:)],'b-')

figure(4)
plot([transStart4(1,:);transEnd4(1,:)],[transStart4(2,:);transEnd4(2,:)],'b-')
