function rimg = hough_transform_custom( bimage )
    %HOUGH_TRANSFORM Summary of this function goes here
    %Detailed explanation goes here
    
    SAMPLE_COUNT = 20000;
    INC = 0.1;
    
    [rows, cols] = find(bimage);
    points = [rows cols].';
    [buckets(:, 1) buckets(:, 2)] = pol2cart(-45:INC:(45-INC), 1);
    samples = generate_vectors(points, SAMPLE_COUNT);
    
    dots = abs(buckets * samples);
    
    [~, indices] = max(dots, [], 1);
    
    votes = hist(indices, 1:size(buckets, 1));
    
    [~, I] = max(votes);
    
    theta = -45 + INC * (I(1) - 1)
    
    rimg = imrotate(bimage, theta, 'bilinear');
end

function vec = generate_vectors(points, k)
    n = size(points, 2);
    vec = points(:, randi(n, 1, k)) - points(:, randi(n, 1, k));
    norms = sqrt(sum(vec.^2));
    vec = vec(:, norms > 0);
    norms = sqrt(sum(vec.^2));
    vec = bsxfun(@rdivide, vec, norms);
end