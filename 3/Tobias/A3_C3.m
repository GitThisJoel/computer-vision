clear
close all
addpath assignment3data

load('compEx3data.mat')
load('compEx1data.mat')
im1 = imread("kronan1.jpg");
im2 = imread("kronan2.jpg");

x1norm = inv(K)*x{1};
x2norm = inv(K)*x{2};

M = zeros(size(x1norm,2),9);
for i=1:size(x1norm,2)
 xx = x2norm(:,i)*x1norm(:,i)'; %finding all the multiplications between two columns
 M(i,:) = (xx(:))'; %replacing the correct row in M
end
[U,S,V] = svd(M);
v = V(:,end);
Eapprox = reshape(v,[3 3]);
[U1,S1,V1] = svd(Eapprox);
if det(U1*V1')>0
    E = U1*diag([1 1 0])*V1';
else
    V1 = -V1;
    E = U1*diag([1 1 0])*V1';

end
E = E./E(3,3);
plot(diag(x2norm'*E*x1norm));   

F = K'*E*K;%????
F = F./F(3,3);
l = pflat(F*x{1});
l = l./sqrt(repmat(l(1,:).^2 +l(2,:).^2,[3 1]));

rand = randperm(size(x{2},2),20); %choosing 20 random numbers
x{2} = x{2}(:,rand); %selecting the corresponding points
l = l(:,rand); % selecting the corresponding lines
figure()
set(2,'DefaultLineLineWidth',1)
imagesc(im2)
hold on
plot(x{2}(1,:),x{2}(2,:),'c*');
rital(l)

d = abs(sum(l.*x{2})); %calculating the distance between line and points
figure()
hist(d,100)
mean(d);

save("A3_C3_variables.mat",'E');

