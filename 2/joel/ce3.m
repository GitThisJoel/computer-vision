close all 

addpath("../assignment2data/");
load("compEx3data.mat");

im1 = imread("cube1.JPG");
im2 = imread("cube2.JPG");

% Normalization
mean_1 = mean(x{1}(1:2,:),2);
std_1  =  std(x{1}(1:2, :), 0, 2);

mean_2 = mean(x{2}(1:2,:),2);
std_2  =  std(x{2}(1:2, :), 0, 2);

N1 = norm_matrix(mean_1, std_1);
N2 = norm_matrix(mean_2, std_2);

norm_x1 = N1*x{1};
norm_x2 = N2*x{2};

% sum = 0;
% for i=1:37
%     sum = sum + norm(norm_x1(:,i),2);
% end 
% sum1 = sum/37
% sum = 0;
% for i=1:37
%     sum = sum + norm(norm_x1(:,i),2);
% end
% sum2 = sum/37

% Plot points
plot_norm = 1;
if plot_norm
    figure('Position',[70 70 1100 450]);
    subplot(1,2,1);
    plot(norm_x1(1,:), norm_x1(2,:), '*')
    title("First camera");
    subplot(1,2,2);
    plot(norm_x2(1,:), norm_x2(2,:), '*')
    title("Second camera");
end 

% Find Ms
M1 = zeros(3*size(Xmodel,2), 3*(size(Xmodel,1)+1)+size(Xmodel,2));
M2 = zeros(3*size(Xmodel,2), 3*(size(Xmodel,1)+1)+size(Xmodel,2));
M1 = M_DLT(M1, norm_x1);
M2 = M_DLT(M2, norm_x2);

% SVD
[U1, S1, V1] = svd(M1);
[U2, S2, V2] = svd(M2);

v1 = V1(:, end);
v2 = V2(:, end);

% Camera matrix
P1 = N1^-1*[v1(1:4)'; v1(5:8)'; v1(9:12)'];
P2 = N2^-1*[v2(1:4)'; v2(5:8)'; v2(9:12)'];

[R1, Q1] = rq(P1);
[R2, Q2] = rq(P2);

% K-matrices
R1 = R1 ./ R1(3, 3);
R2 = R2 ./ R2(3, 3);

% Plotting
% [startX, startY, width, height]
figure('Position',[100 100 1100 370]);
subplot(1,2,1);
plot_camera(P1, x, im1, 1);
title("First camera")

%figure();
subplot(1,2,2);
plot_camera(P2, x, im2, 2);
title("Second camera")

figure();
hold on
plot3 ([Xmodel(1, startind); Xmodel(1, endind)],...
[Xmodel(2, startind); Xmodel(2, endind )],...
[Xmodel(3, startind); Xmodel(3, endind )] , 'b-');
plotcams({P1, P2})
title("Model and camera centers")

save('CE3_variables','P1','P2','R1','R2');

function N = norm_matrix(mean_xy, std_xy)
    s = 1./std_xy;
    N = [s(1)   0       -s(1)*mean_xy(1);
         0      s(2)    -s(2)*mean_xy(2);
         0      0       1];
end 

function M = M_DLT(M, x)
    load compEx3data.mat Xmodel;
    s1 = size(Xmodel,1);
    s2 = size(Xmodel,2);
    
    Xmodel = [Xmodel; ones(1,size(Xmodel,2))];
    for i=1:size(Xmodel,2)
        tmp_segment = zeros(s1, 3*(s1+1)+s2);
        
        tmp_segment(1,1:4)  = Xmodel(:,i)';
        tmp_segment(2,5:8)  = Xmodel(:,i)';
        tmp_segment(3,9:12) = Xmodel(:,i)';
        
        tmp_segment(:, 12+i) = -x(:,i);
        
        M(1+(i-1)*3:3+(i-1)*3, :) = tmp_segment;
    end
end

function plot_camera(P, x, im, i)
    % (fplat P1 * Xmodel, x1, im1)
    load compEx3data.mat Xmodel;
    
    Xmodel = [Xmodel; ones(1,size(Xmodel,2))];
    proj = pflat(P*Xmodel);
    
    imagesc(im);
    hold on
    plot(proj(1,:), proj(2,:), 'r*');
    plot(x{i}(1,:), x{i}(2,:), 'bo');
end 