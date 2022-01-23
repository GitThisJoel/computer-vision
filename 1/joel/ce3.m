clear all;
close all;

addpath("assignment1data/");
load("compEx3.mat");

H_1 = [3 -1 1;  1 sqrt(3) 1;  0   0 2];
H_2 = [1 -1 1;  1 1       0;  0   0 1];
H_3 = [1  1 0;  0 2       0;  0   0 1];
H_4 = [3 -1 1;  1 sqrt(3) 1; .25 .5 2];

Hs = [H_1 H_2 H_3 H_4];

figure()
for i=0:3
    subplot(2,2,i+1);
    plot_projection(Hs(:, i*3+1:3+i*3));
    ind = i+1;
    title("H_" + ind);
end

function plot_projection(H)
    load compEx3.mat startpoints endpoints;
    
    hold on
    %plot([startpoints(1, :); endpoints(1, :)] , ...
    %     [startpoints(2, :); endpoints(2, :)], 'r-', 'Color',[1, 0, 0, 0.3]);
   
%     for i=1:length(p)
%         p(i).Color = [p(i).Color 1];  % alpha=0.1
%     end
    
    sp = pflat(H * [startpoints; ones(1, size(startpoints,2))]);
    ep = pflat(H * [endpoints;   ones(1, size(endpoints, 2))]);
    
    plot([sp(1, :); ep(1, :)] , ...
         [sp(2, :); ep(2, :)], 'b-');

    axis equal 
end 
