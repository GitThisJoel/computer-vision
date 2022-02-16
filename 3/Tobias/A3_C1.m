clear
close all
clc
addpath assignment3data
load('compEx1data.mat')
im2 =imread("kronan2.jpg");

N1 = normMatrix(x{1}); %creating normalization matrices
N2 = normMatrix(x{2});
%N1 = eye(3);
%N2 = eye(3);

x1 = N1*x{1};
x2 = N2*x{2};

%creating M
M = zeros(size(x1,2),9);
for i=1:size(x1,2)
 xx = x2(:,i)*x1(:,i)'; %finding all the multiplications between two columns
 M(i,:) = xx(:)'; %replacing the correct row in M
end
[U,S,V] = svd(M); %solving the system
v = V(:,end); %extracting the solution 
norm(M*v,2); %checking that this is close to 0

F_tilde = reshape(v,[3 3]); %finding the normalized F
[U1,S1,V1] = svd(F_tilde);
S1(3,3) = 0; % making sure that F_tilde has a determinant close to 0
F_tilde = U1*S1*V1';
plot(diag(x2'*F_tilde*x1)); %plotting all the epipolar constraints

F = N2'*F_tilde*N1; %finding the un-normalized F
F=F./F(3,3);
l = pflat(F*x{1}); %computing the epipolar lines
l = l./sqrt(repmat(l(1,:).^2 +l(2,:).^2,[3 1]));


d = abs(sum(l.*x{2})); %calculating the distance between line and points
figure()
hist(d,100)
mean(d)

rand = randperm(size(x{2},2),20); %choosing 20 random numbers
x{2} = x{2}(:,rand); %selecting the corresponding points
l = l(:,rand); % selecting the corresponding lines
figure()
set(3,'DefaultLineLineWidth',1)
imagesc(im2)
hold on
plot(x{2}(1,:),x{2}(2,:),'c*');
rital(l)


save('A3_C1_variables.mat','F','N2','N1','F_tilde');

function f = normMatrix(x)
m = mean(x(1:2,:),2);
s  = std(x(1:2,:),0,2);
f = [1/s(1) 0 -m(1)/s(1);
    0 1/s(2) -m(2)/s(2);
    0  0 1];
end