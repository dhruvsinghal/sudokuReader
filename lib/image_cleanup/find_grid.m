function grid = find_grid( bimage, max_width, max_gap, max_width_skips, ...
    min_vertical, min_horizontal )
%FIND_GRID For every row and column in the 'bimage' return another image of
%the same dimensions such that it contains only the longest connected 
%regions (lines) in every row and column.
%
%It also places constraints on such regions. Each connected line can have
%gaps that are at most 'max_gap' pixels long. Its width must also not
%exceed 'max_width' allowing 'max_width_skips' pixels to be skipped.
%Finally, it must be of minimum length 'min_vertical' for vertical lines
%and 'min_horizontal' for horizontal lines.
%
%See FIND_CONNECTED_LINES for more details.

[n_rows, n_cols] = size(bimage);

grid = zeros(n_rows, n_cols);

for i = 1 : n_rows
    [l_start, l_end] = find_connected_line(bimage, 'row', i,...
        max_gap, max_width, max_width_skips);
    
    if (l_end - l_start + 1) > min_vertical
        grid(i, l_start:l_end) = 1;
    end
end

for i = 1 : n_cols
    [l_start, l_end] = find_connected_line(bimage, 'col', i, ...
        max_gap, max_width, max_width_skips);
    
    if (l_end - l_start + 1) > min_horizontal
        grid(l_start:l_end, i) = 1;
    end
end

end