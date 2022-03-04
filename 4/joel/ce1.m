addpath('../assignment4data')
addpath("../../vlfeat-0.9.21/toolbox");
vl_setup;

A = imread('a.jpg');
B = imread('b.jpg');


[fA dA] = vl_sift(single(rgb2gray(A)));%, 'PeakThresh' , 1);
[fB dB] = vl_sift(single(rgb2gray(B)));%, 'PeakThresh' , 1);
% vl_plotframe(f1);
[matches, scores] = vl_ubcmatch(dA, dB);

xA = fA(1:2, matches(1,:));
xB = fB(1:2, matches(2,:));

for j=1:size(x1_norm, 2)
    M = [P1 -x1_norm(:,j) zeros(3,1);
        P2 zeros(3,1) -x2_norm(:,j)];
    [U, S, V] = svd(M);
    v = V(:, end);
    xs(:,j) = v(1:4);


% Htform = projective2d(bestH');
% 
% Rout = imref2d(size(A), [-200 800], [-400 600]);
% 
% [Atransf] = imwarp(A, Htform, 'OutputView', Rout);
% 
% Idtform = projective2d (eye(3));
% [Btransf] = imwarp(B, Idtform, 'OutputView', Rout);
% 
% AB = Btransf;
% AB(Btransf < Atransf) = Atransf(Btransf < Atransf);
% 
% imagesc(Rout.XWorldLimits, Rout.YWorldLimits ,AB);



