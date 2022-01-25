function h_points = pflat(points)
    h_points = points(:, :) ./ points(end, :);
end 
