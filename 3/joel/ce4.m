clear
close all

addpath("functions");

addpath("../assignment3data/");
load compEx1data.mat
load compEx3data.mat

load ce1_variables.mat
load ce3_variables.mat

im1 = imread("kronan1.JPG");
im2 = imread("kronan2.JPG");

norm_x1 = K^-1 * x{1};
norm_x2 = K^-1 * x{2};

[U, S, V] = svd(E);

P1 = [eye(3,3) zeros(3,1)];
P2 = create_cm(E);

% M matrix
x1_norm = K^-1*x{1};
x2_norm = K^-1*x{2};

[P2_best, X_best] = dlt_infront(P1, P2, x1_norm, x2_norm);

P1 = K*P1;
P2_best = K*P2_best;

xproj1 = pflat(P1*X_best);
xproj2 = pflat(P2_best*X_best);
X_best = pflat(X_best);

figure();
plot_proj(xproj1, x{1}, im1)

figure();
plot_proj(xproj2, x{2}, im2)

figure();
plot3(X_best(1,:), X_best(2,:), X_best(3,:), '.', 'Markersize', 2)
hold on
plotcams({P1}, 'g')
plotcams(P2)
axis equal

function plot_proj(xproj, x, im)
    imagesc(im);
    hold on;
    plot(x(1,:), x(2,:), 'bo');
    plot(xproj(1,:), xproj(2,:), 'r*');
end 



