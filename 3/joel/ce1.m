clear
close all

addpath("functions");

addpath("../assignment3data/");
load compEx1data.mat
im1 = imread("kronan1.JPG");
im2 = imread("kronan2.JPG");

% Normalization
mean_1 = mean(x{1}(1:2,:),2);
std_1  =  std(x{1}(1:2, :), 0, 2);

mean_2 = mean(x{2}(1:2,:),2);
std_2  =  std(x{2}(1:2, :), 0, 2);

N1 = norm_matrix(mean_1, std_1);
N2 = norm_matrix(mean_2, std_2);

% N1 = eye(size(N1));
% N2 = eye(size(N2));

norm_x1 = N1*x{1};
norm_x2 = N2*x{2};

% Find Ms
% xi' * F * xi = 0
M = zeros(size(norm_x1,2), 9);
for i=1:size(norm_x1,2)
    r = norm_x2(:,i) * norm_x1(:,i)';
    M(i,:) = r(:)';
end 

[U, S, V] = svd(M);
v = V(:,end);
norm(M*v, 2);

F_t = reshape(v, [3 3]);
[Ut, St, Vt] = svd(F_t);
St(3,3) = 0;
det(F_t); % very close to 0
norm_x2(:,1)'*F_t*norm_x1(:,1);

F_t = Ut * St * Vt';
figure();
plot(diag(norm_x2'*F_t*norm_x1));
title("Epipolar constraints")

F = N2'*F_t*N1;
F = F ./ F(3,3);

% epipolar lines
l = pflat(F*x{1});
l = l ./ sqrt(repmat(l(1, :).^2 + l(2, :).^2 ,[3 1]));


% histogram
figure();
hist(abs(sum(l.*x{2})),100);

% random points and lines
r = randi([1 size(norm_x1, 2)],1,20);
p = x{2}(:,r);
figure();
set(3,'DefaultLineLineWidth',1)
imagesc(im2);
hold on
rital(l(:,r));
plot(p(1,:), p(2,:), 'c*')
title("Random points and epipolar lines")


% norm: 0.1535
% unnorm: 0.2421
d = mean(abs(sum(l.*x{2})))

save("ce1_variables", "F", "N1", "N2", "F_t");
        
function N = norm_matrix(mean_xy, std_xy)
    s = 1./std_xy;
    N = [s(1)   0       -s(1)*mean_xy(1);
         0      s(2)    -s(2)*mean_xy(2);
         0      0       1];
end 

