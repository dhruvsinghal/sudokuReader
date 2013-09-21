function [max_start, max_end] = find_connected_line(image,...
    row_col_indentifier, index, max_gap, max_width, max_width_skips)
%FIND_CONNECTED_LINE Return the endpoints of line such that it is roughly
%connected, with gaps at most 'max_gap' pixels long, and which is at most 
%'max_width' wide, except for 'max_gap' pixel stretches. This means that 
%those regions of a line where its width exceed max_width are counted as 
%blank regions.
%
%The 'row_col_identifier' is a string, either 'row' or col', which
%indicates whether the 'index' specifies is a row index or a column index.
%
%See GROW_CONNECTED_REGION for more details.

is_row = strcmpi(row_col_indentifier, 'row');

if is_row
    n_elements = size(image, 2);
else
    n_elements = size(image, 1);
end

max_start = 0;
max_end = 0;

curr_start = 0;
curr_end = 0;

skipped = 0;

for i = 1 : n_elements
    if (is_row && image(index, i)) || (~is_row && image(i, index)) % pixel
        if is_row
            [g_start, g_end] = grow_connected_region(image(:, i), index, max_width_skips);
        else
            [g_start, g_end] = grow_connected_region(image(i, :), index, max_width_skips);
        end
        width = g_end - g_start + 1;
    else
        width = 0;
    end
    
    % For a pixel to be considered to be 'in' the connected region, it must
    % both be non-zero and must have a 'width' less than max_width.
    if width > 0 && width <= max_width
        skipped = 0;
        curr_end = i;
        if curr_start == 0
            curr_start = i;
        end
    else
        skipped = skipped + 1;
    end
    
    if curr_start > 0 && ( skipped > max_gap || i == n_elements )
        if (curr_end - curr_start) > (max_end - max_start)
            max_start = curr_start;
            max_end = curr_end;
        end
        skipped = 0;
        curr_start = 0;
        curr_end = 0;
    end
end
end

