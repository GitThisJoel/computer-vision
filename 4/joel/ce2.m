clear
close all

addpath('../assignment4data')
load('compEx2data.mat')
addpath("../../vlfeat-0.9.21/toolbox");
vl_setup;

im1 = imread('im1.jpg');
im2 = imread('im2.jpg');

x{1} = [x{1}; ones(1, size(x{1},2))];
x{2} = [x{2}; ones(1, size(x{2},2))];

x1 = x{1};
x2 = x{2};

x1_norm = K^-1 * x1;
x2_norm = K^-1 * x2;

min_iter = 5;
min_corr = 5;

nbest_inls = 0;
best_inls = [];
best_E = [];
for i=1:min_iter*20
    r = randperm(size(x1_norm, 2), min_corr);
    rx1_norm = x1_norm(:,r);
    rx2_norm = x2_norm(:,r);
    
    E = fivepoint_solver(rx1_norm, rx2_norm);
    
    for j=1:size(E,2)
        F = (K^-1)'*E{j}*K^-1;
        
        % epipole in image 1
        l1 = pflat(F'*x2);
        l1 = l1 ./ sqrt(repmat(l1(1, :).^2 + l1(2, :).^2 ,[3 1]));

        % epipole in image 2
        l2 = pflat(F*x1);
        l2 = l2 ./ sqrt(repmat(l2(1, :).^2 + l2(2, :).^2 ,[3 1]));
        
        d1 = abs(sum(l1.*x1)); % d1 = distance(l1, x1);
        d2 = abs(sum(l2.*x2)); % d2 = distance(l2, x2);
        
        inls = (d1 < 5) & (d2 < 5);
        
        nbr_inls = sum(inls(:));
        if nbr_inls > nbest_inls
            best_E = E{j};
            nbest_inls = nbr_inls;
            best_inls = inls;
        end 
    end 
end
disp("number of inliers = " + nbest_inls);

P1 = [eye(3) zeros(3, 1)];
P2 = create_cm(best_E);

[P2_best, X_best] = dlt_infront(P1, P2, x1_norm, x2_norm);
P1 = K*P1;
P2_best = K*P2_best;
X_best = pflat(X_best);

x ={x{1}(:,best_inls==1),x{2}(:,best_inls==1)};

X_best=X_best(:,best_inls==1);

[err, res] = ComputeReprojectionError({P1, P2_best}, X_best, x);
RMS = sqrt(err/size(res,2));

figure()
hist(res,100)

figure()
plot3(X_best(1,:), X_best(2,:), X_best(3,:), '.', 'Markersize', 2.5)
axis equal
hold on
plotcams({P1, P2_best})

P2 = P2_best;
X = X_best;
save('ce2_variables', 'P1', 'P2', 'X', 'x');

function dis = distance(line, points)
    a = line(1); b = line(2); c = line(3);
    x1 = points(1,:); x2 = points(2,:);
    
    dis = abs(a*x1 + b*x2 + c) ./ sqrt(a^2 + b^2);
end 

