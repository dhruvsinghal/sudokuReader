function val = is_mostly_empty(img)
% Return true iff (1) the image is mostly dark, and/or (2) the median pixel
% lies near one of the edges (in case of the grid lines leaking into
% the test box).

PIXEL_COUNT_THRESHOLD = 0.02;
CENTER_DEVIATION_THRESHOLD = 0.30;

[rows, cols] = find(img);
width = size(img, 1);
height = size(img, 2);

if length(rows) > PIXEL_COUNT_THRESHOLD * numel(img)
    x_center = ceil(width/ 2);
    y_center = ceil(height/ 2);
    x_dev = abs(x_center - median(cols));
    y_dev = abs(y_center - median(rows));
     if x_dev > CENTER_DEVIATION_THRESHOLD * width || ...
             y_dev > CENTER_DEVIATION_THRESHOLD * height
         val = true;
     else
        val = false;
    end
    
else
    val = true;
end
end