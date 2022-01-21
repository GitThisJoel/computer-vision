% load('assignment1data\compEx1.mat')
% 
% h_x2D = pflat(x2D);
% h_x3D = pflat(x3D);
% 
% figure();
% hold on
% subplot(2,2,1);
% plot(x2D(1, :), x2D(2, :), '.');
% title("2D points")
% 
% subplot(2,2,2);
% plot(h_x2D(1, :), h_x2D(2, :), '.');
% title("Homogeneous 2D points")
% 
% subplot(2,2,3);
% plot3(x3D(1, :), x3D(2, :), x3D(3, :), '.');
% title("3D points")
% 
% subplot(2,2,4);
% plot3(h_x3D(1, :), h_x3D(2, :), h_x3D(3, :), '.');
% title("Homogeneous 3D points")
% hold off

function h_points = pflat(points)
    h_points = points(:, :) ./ points(end, :);
end 