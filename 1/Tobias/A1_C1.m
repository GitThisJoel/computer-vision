clear all
close all

load('compEx1.mat');

m2D = pflat(x2D); %dividing the coordinates with their last entry
m3D = pflat(x3D);

axis equal

figure(1)
plot(m2D(1,:),m2D(2,:),'.')
figure(2)
plot3(m3D(1,:),m3D(2,:),m3D(3,:),'.')
