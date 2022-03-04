clear
close all

addpath("functions");

addpath("../assignment3data/");
load compEx1data.mat

load ce1_variables.mat

im1 = imread("kronan1.JPG");
im2 = imread("kronan2.JPG");

e2 = null(F_t'); % Computes the epipole
e2x = [0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0]; % Constructs the cross product matrix

P1 = [eye(3,3) zeros(3,1)];
P2 = [e2x*F_t e2];

x1_norm = N1*x{1};
x2_norm = N2*x{2};

X = [];
for i=1:size(x1_norm, 2)
    M = [P1 -x1_norm(:,i) zeros(3,1); 
         P2 zeros(3,1) -x2_norm(:,i)];
    [U,S,V] = svd(M);
    v = V(:, end);
    X = [X v(1:4)]; %length of X = (x y z w)
end
X = pflat(X);

% Restoring cameras
P1 = N1^-1 * P1;
P2 = N2^-1 * P2;

d = depth(P2, X);
if sign(max(d)) ~= sign(min(d))
    % swtich col
    P1 = switch_34(P1);
    P2 = switch_34(P2);
    
    % switch row
    temp = X(3,:);
    X(3,:) = X(4,:);
    X(4,:) = temp;
    X = pflat(X);
end 

xproj1 = pflat(P1 * X);
xproj2 = pflat(P2 * X);

figure();
plot_proj(xproj1, x{1}, im1)

figure();
plot_proj(xproj2, x{2}, im2)

figure();
plot3(X(1,:), X(2,:), X(3,:), '.')
axis equal

function plot_proj(xproj, x, im)
    imagesc(im);
    hold on;
    plot(x(1,:), x(2,:), 'bo');
    plot(xproj(1,:), xproj(2,:), 'r*');
end 

function P = switch_34(P)
    temp = P(:,3);
    P(:,3) = P(:,4);
    P(:,4) = temp;
end



