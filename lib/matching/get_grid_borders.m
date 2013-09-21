function [ left, right, top, bottom ] = get_grid_borders( image )
%GET_GRID_BORDERS Returns the four borders of the sudoku grid.

MAX_WIDTH = 5;
MAX_GAP = 15;
MAX_WIDTH_SKIPS = 10;
MIN_VERTICAL = 20;
MIN_HORIZONTAL = 20;

image = find_grid(image , MAX_WIDTH, MAX_GAP, MAX_WIDTH_SKIPS, ...
                  MIN_VERTICAL, MIN_HORIZONTAL);
image = largest_component(image);
[rows, cols] = find(image);

left = min(cols);
right = max(cols);
top = min(rows);
bottom = max(rows);

if (right - left) <= 0 || (bottom - top) <= 0
    error('No proper border detected.');
end

% Now adjust the above values for the thickness of borders by randomly
% sampling rows and columns within the grid.
x = zeros(1, 10);
y = zeros(1, 10);
for i = 1 : 10
    if mod(i, 2)
        dir = 'first';
    else
        dir = 'last';
    end
    rand_row = randi([top bottom], 1, 1);
    x(i) = border_width(image(rand_row, :), dir);
end

for i = 1 : 10
    if mod(i, 2)
        dir = 'first';
    else
        dir = 'last';
    end
    rand_col = randi([left right], 1, 1);
    y(i) = border_width(image(:, rand_col), dir);
end
left = left + median(x);
right = right - median(x);
top = top + median(y);
bottom = bottom - median(y);

end

function len = border_width(vec, direction)
% Return the width of the border determined using the row/col 'vec' in the
% given 'direction' ('first' or 'last').
index = find(vec, 1, direction);
if isempty(index)
    len = 0;
else
    [region_start, region_end] = grow_connected_region(vec, index, 2);
    len = region_end - region_start + 1;
end

end