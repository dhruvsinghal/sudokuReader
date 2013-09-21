function [ region_start, region_end ] = grow_connected_region( vec, ...
                                                        index, max_skips )
%GROW_CONNECTED_REGION Return the bounds for the connected region in the
%given vector 'vec' that includes the specified 'index'.
%
%A connected region of a vector is a sequence of elements with at most
%'max_skip' zero element between every non-zero pixel.

if vec(index) == 0
    error('The index %d does not lie in a connected component.', index);
end

region_start = index;
region_end = index;

% Grow toward the start of the vector
i = index;
skips = 0;
while i > 0 && skips <= max_skips
    if vec(i) ~= 0
        region_start = i;
        skips = 0;
    else
        skips = skips + 1;
    end
    i = i - 1;
end

% Grow toward the end of the vector
skips = 0;
i = index;
while i <= length(vec) && skips <= max_skips
    if vec(i) ~= 0
        region_end = i;
        skips = 0;
    else
        skips = skips + 1;
    end
    i = i + 1;
end

end

