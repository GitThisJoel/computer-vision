addpath("../assignment2data/");
load compEx1data.mat

close all

T1 = [1 0 0 0; 0 4 0 0; 0 0 1 0; 0.1 0.1 0 1];
T2 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 1/16 1/16 0 1];

plot_original = 1;
if plot_original
    figure();
    hold on
    plot3(X(1,:), X(2,:), X(3,:), 'b.');
    plotcams(P)
end 

figure()
plot_image_proj(1, P, X, x)

X1_t = pflat(T1*X); % not T1\X
X2_t = pflat(T2*X); % not T2\X

P1 = P;
P2 = P;

% new camera matrices
for i=1:9 
    P1{i} = P{i} * T1^-1;
    P2{i} = P{i} * T2^-1;
end 

figure();
% subplot(1, 2, 1);
hold on
plot3(X1_t(1,:), X1_t(2,:), X1_t(3,:), 'b.', 'Markersize' , 2);
axis equal
plotcams(P1)

figure();
%subplot(1, 2, 2);
plot3(X2_t(1,:), X2_t(2,:), X2_t(3,:), 'b.', 'Markersize' , 2);
hold on
axis equal
plotcams(P2)

for i=1:1
    figure()
    plot_image_proj(i, P1, X1_t, x);
end

for i=1:1
    figure()
    plot_image_proj(i, P2, X2_t, x);
end

figure();
subplot(1,2,1);
plot_image_proj(i, P1, X1_t, x);
title("Image projection of X1")

subplot(1,2,2);
plot_image_proj(i, P2, X2_t, x);
title("Image projection of X2")


function plot_image_proj(i, P, X, x)
    load compEx1data.mat imfiles;
    
    xproj = pflat(P{i} * X);
    im = imread(imfiles{i});
    visible = isfinite(x{i}(1 ,:));
    
    hold on 
    imagesc(im)
    plot(x{i}(1, visible), x{i}(2, visible), 'b*');
    plot(xproj(1, visible), xproj(2, visible), 'ro');
end 



