addpath("assignment1data/");
load("compEx4.mat");

im1 = imread("assignment1data/compEx4im1.JPG");
im2 = imread("assignment1data/compEx4im2.JPG");

P1 = K * [R1 t1];
P2 = K * [R2 t2];

C1 = camera_center(P1);
C2 = camera_center(P2);

PA1 = viewing_dir(R1);
PA2 = viewing_dir(R2);

h_U = pflat(U);
plot_3d = 0;
plot_2d = 1;

if plot_3d
    figure(1);
    hold on
    plot3(h_U(1,:), h_U(2,:), h_U(3,:), '.', 'Markersize', 2);
    
    quiver3 (C1(1), C1(2), C1(3), PA1(1), PA1(2), PA1(3), 10);
    quiver3 (C2(1), C2(2), C2(3), PA2(1), PA2(2), PA2(3), 10);
    title("camera center and viewing directions");
end

if plot_2d
    U1 = pflat(P1*U);
    U2 = pflat(P2*U);
    
    figure(2)
    subplot(2,1,1);
    hold on
    imagesc(im1);
    colormap(gray)
    plot(U1(1,:), U1(2,:), '.', 'Markersize', 2);
    title("first image")
    
    subplot(2,1,2);
    hold on
    imagesc(im2);
    colormap(gray)
    plot(U2(1,:), U2(2,:), '.', 'Markersize', 2);
    title("second image")
end 

function C = camera_center(P)
    C = pflat(null(P));
end 

function V = viewing_dir(R)
    V = R(end, :);
end 