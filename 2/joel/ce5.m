addpath("..\assignment2data");

load("compEx3data.mat");
load("CE3_variables.mat");
load("CE4_variables.mat");

im1 = imread("cube1.JPG");
im2 = imread("cube2.JPG");

Xmodel = [Xmodel; ones(1, size(Xmodel, 2))];

% Normalization 
x1 = pflat(R1^-1 * [x1; ones(1, size(x1, 2))]);
x2 = pflat(R2^-1 * [x2; ones(1, size(x2, 2))]);
P1 = R1^-1 * P1;
P2 = R2^-1 * P2;

X = [];
for i=1:size(x1,2)
    M = [P1 -x1(:,i) zeros(3,1); 
         P2 zeros(3,1) -x2(:,i)];
    [U,S,V] = svd(M);
    v = V(:, end);
    X = [X v(1:4)]; %length of X = (x y z w)
end

% pflat X
X = pflat(X);

% Restoring cameras
P1 = R1 * P1;
P2 = R2 * P2;

% proj X in image, i.e. mult with K
xproj1 = pflat(P1 * X);
xproj2 = pflat(P2 * X);    

x1 = pflat(R1*x1);
x2 = pflat(R2*x2);

% Plot proj and target
figure();
plot_proj(xproj1, x1, im1);

figure();
plot_proj(xproj2, x2, im2);

% Extract good points (not more than 3 pixels away from target)
good_points = (sqrt(sum((x1(1:2, :)-xproj1(1:2, :)).^2)) < 3 & ...
               sqrt(sum((x2(1:2, :)-xproj2(1:2, :)).^2)) < 3);
X = X(:, good_points);

% Plot the good points
figure();
plot3 ([Xmodel(1, startind); Xmodel(1, endind)],...
[Xmodel(2, startind); Xmodel(2, endind )],...
[Xmodel(3, startind); Xmodel(3, endind )] , 'b-');
hold on
plot3(X(1,:), X(2,:), X(3,:),'r.', 'Markersize', 2)
plotcams({P1, P2})


function plot_proj(xproj, x, im)
    imagesc(im);
    hold on;
    plot(x(1,:), x(2,:), 'bo');
    plot(xproj(1,:), xproj(2,:), 'r*');
end 



