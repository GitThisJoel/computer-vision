clear
close all

addpath("functions");

addpath("../assignment3data/");
load compEx1data.mat
load compEx3data.mat

load ce1_variables.mat

im1 = imread("kronan1.JPG");
im2 = imread("kronan2.JPG");

norm_x1 = K^-1 * x{1};
norm_x2 = K^-1 * x{2};

M = zeros(size(norm_x1,2), 9);
for i=1:size(norm_x1,2)
    r = norm_x2(:,i) * norm_x1(:,i)';
    M(i,:) = r(:)';
end 

% svd
[U, S, V] = svd(M);
v = V(:,end);
norm(M*v,2); % ok!

% essential matrix
Eapprox = reshape(v, [3 3]);
[U, S, V] = svd(Eapprox);
if det(U*V')>0
    E = U * diag([1 1 0])* V';
else
    V = -V;
    E = U * diag([1 1 0])* V';
end
norm_x2(:,1)'*E*norm_x1(:,1); % ok!
E = E ./ E(3,3);

F = (K^-1)'*E*K^-1;
F = F ./ F(3,3);

l = pflat(F*x{1});
l = l ./ sqrt(repmat(l(1, :).^2 + l(2, :).^2 ,[3 1]));

% random points and lines
r = randi([1 size(norm_x1, 2)],1,20);
p = x{2}(:,r);
figure();
imagesc(im2);
set(0,'DefaultLineLineWidth',1) % 0 is fig nr.
hold on
rital(l(:,r));
plot(p(1,:), p(2,:), 'c*')
title("Random points and epipolar lines")

% histogram
figure();
hist(abs(sum(l.*x{2})),100);

% save("ce3_variables", "E");


