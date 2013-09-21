function theta = hough_transformZZ( bimage )
    %HOUGH_TRANSFORM Summary of this function goes here
    %   Detailed explanation goes here
    
    N_ROUNDS = 6000;
    N_POINTS = 2;
    
    [rows, cols] = find(bimage);
    n_pixels = size(rows, 1);
    points = zeros(N_ROUNDS, 1);
    
    for i = 1 : N_ROUNDS
        ind = randperm(n_pixels, N_POINTS);
        points(i, :) = fit_line(rows(ind), cols(ind));
    end
    cluster = kmeans(points, 2);
    m1 = median(points(cluster == 1));
    m2 = median(points(cluster == 2));
    theta = max(m1, m2); % Pick one. Choose the greater for consistency
    
end

function point = fit_line(r, c)

m = abs((c(2) - c(1)) / (r(2) - r(1)));
point = atand(-1/m);
end