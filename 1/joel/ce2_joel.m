addpath("assignment1data/");

im = imread("assignment1data/compEx2.jpg");

figure()
imagesc(im);
colormap(gray);

hold on
plot_points(p1, 'r*')
plot_points(p2, 'g*')
plot_points(p3, 'b*')

lines = [null(p1') null(p2') null(p3')];
    
rital(lines(:,1), 'r-')
rital(lines(:,2), 'g-')
rital(lines(:,3), 'b-')

inters = null([lines(:,2) lines(:,3)]');
h_inters = inters ./ inters(end);
plot_points(h_inters, 'm*')

d = distance (lines(:,1), h_inters(1:2))

hold off

function plot_points(ps, c)
    for i=1:size(ps,2)
        plot(ps(1,i), ps(2,i), c)
    end 
end 

function dis = distance(line, point)
    a = line(1); b = line(2); c = line(3);
    x1 = point(1); x2 = point(2);
    
    dis = abs(a*x1 + b*x2 + c) / sqrt(a^2 + b^2);
end 