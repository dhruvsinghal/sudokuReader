function theta = hough_transform_custom( bimage )
    %HOUGH_TRANSFORM Summary of this function goes here
    %   Detailed explanation goes here
    
    ANGLE_THRESHOLD = 3;
    COSINE_THRESHOLD = cos(ANGLE_THRESHOLD*pi/180);
    BUCKET_COUNT = 10000;
    SAMPLE_COUNT = 10000;
    
    [rows, cols] = find(bimage);
    points = [rows cols].';
    buckets = generate_vectors(points, BUCKET_COUNT);
    samples = generate_vectors(points, SAMPLE_COUNT);
    
    dots = abs(buckets.' * samples);
    
    counts = sum(dots > COSINE_THRESHOLD, 2);
    
    [z, I] = max(counts);
    z(1)
    
    v = abs(buckets(:,I(1)));
    theta = 90 - (atan(v(2)/ v(1)) * 180 / pi);
end

function vec = generate_vectors(points, k)
n = size(points, 2);
vec = points(:, randperm(n, k)) - points(:, randperm(n, k));
norms = sqrt(sum(vec.^2));
vec = bsxfun(@rdivide, vec, norms);
end