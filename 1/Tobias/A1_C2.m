clear all
close all

Im = imread('compEx2.JPG');
load('compEx2.mat');

figure(1)
set(1,'DefaultLineLineWidth',1)
imagesc(Im);
hold on
colormap gray;
%plotting the 3 pair of points
plot(p1(1,1:2),p1(2,1:2),'r*');
plot(p2(1,1:2),p2(2,1:2),'g*');
plot(p3(1,1:2),p3(2,1:2),'c*');

%finding the line between the pairs of points by computing the null space
line=[null(p1') null(p2') null(p3')];

rital(line)

%calculating intersect of line 2 and 3 by calculating the null space again
intersect = pflat(null([line(:,2) line(:,3)]'));
plot(intersect(1,1),intersect(2,1),'b*')

%calculating the distance between line 1 and the intersect
d = abs(line(:,1)'*intersect)/hypot(line(1,1),line(2,1)) %??

