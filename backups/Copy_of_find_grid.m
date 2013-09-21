function grid = find_grid( bimage )
%FIND_GRID

[lbl, n] = bwlabel(bimage, 8);
cc_counts = zeros(1, n);
for i = 1 : n
    img = lbl == i;
    cc_counts(i) = length(find(img));
end
[~, conn_comp] = sort(cc_counts, 'descend');

for i = 1 : length(conn_comp)
    grid = lbl == conn_comp(i);
    if is_potential_grid(grid)
        [d, n_bright] = density(grid);
        if d < min_density
            min_index = i;
            min_density = d;
        end
    end
end
if min_index == 0
    error('No grid found');
end
grid = lbl == min_index;

end

function val = is_potential_grid(bimage)

img_edge = edge(bimage, 'canny');
[H, theta, ~] = hough(img_edge, 'theta', -90:5:0);
V = houghpeaks(H, 1);
a = theta(V(1, 2));
val = (a == -90) || (a == 0);
end

function lines = find_median_line(