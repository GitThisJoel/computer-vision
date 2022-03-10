clear
close all

addpath('../assignment4data')
addpath("../../vlfeat-0.9.21/toolbox");
vl_setup;

A = imread('a.jpg');
B = imread('b.jpg');

[fA dA] = vl_sift(single(rgb2gray(A)));
[fB dB] = vl_sift(single(rgb2gray(B)));
% vl_plotframe(f1);
[matches, scores] = vl_ubcmatch(dA, dB);

xA = [fA(1:2, matches(1,:)); ones(1, size(matches,2))];
xB = [fB(1:2, matches(2,:)); ones(1, size(matches,2))];

best_H = [];
most_inls = 0;
min_corr = 4;
for i=1:30
    r = randperm(size(xA, 2), min_corr);
    rxA = xA(:,r);
    rxB = xB(:,r);
    M = zeros(3*size(rxA,2), 3*size(rxA,1)+min_corr);
    
    row = 1;
    col = 3*size(rxA,1)+1;
    for j=1:size(rxA, 2)
        n = size(rxA,1);
        m = [rxA(:,j)'    zeros(1,2*n); 
             zeros(1,n)  rxA(:,j)' zeros(1,n); 
             zeros(1, 2*n)        rxA(:,j)'];  
         M(row:row+2, 1:9) = m;
         M(row:row+2, col) = -rxB(:,j);
         
         row = row + 3;
         col = col + 1;
    end
    
    [U, S, V] = svd(M);
    v = V(:, end);
    H = [v(1:3)'; v(4:6)'; v(7:9)'];
    
    txA = zeros(size(xA));
    for j=1:size(xA,2)
        txA(:,j) = pflat(H*xA(:,j));
    end 
    
    inls = sqrt(sum((txA(1:2,:) - xB(1:2,:)).^2))<5;
    nbr_inls = sum(inls(:) == 1);
    if nbr_inls > most_inls
        best_H = H;
        most_inls = nbr_inls;
    end 
end

Htform = projective2d(best_H');

% Rout = imref2d(size(A), [-200 1600], [-400 1800]);
Rout = imref2d(size(A), [-200 800], [-400 600]);

[Atransf] = imwarp(A, Htform, 'OutputView', Rout);

Idtform = projective2d (eye(3));
[Btransf] = imwarp(B, Idtform, 'OutputView', Rout);

AB = Btransf;
AB(Btransf < Atransf) = Atransf(Btransf < Atransf);

imagesc(Rout.XWorldLimits, Rout.YWorldLimits ,AB);



