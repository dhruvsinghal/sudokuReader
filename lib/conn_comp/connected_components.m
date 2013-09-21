function [ labeled, num_components ] = connected_components(bimage)
% Compute an image 'labeled' where every pixel is labeled with the
% connected component it is in, and return the number of components

    [num_rows, num_cols] = size(bimage);
    labeled = zeros(num_rows, num_cols);
    num_components = 0;
    label = 1;

    while true
        % Search for an unlabeled 1

        [nz_rows, nz_cols] = find(labeled < bimage);
        num_nz_elements = length(nz_rows);

        if num_nz_elements == 0
            break;
        end

        % Found an unlabeled 1
        root_row = nz_rows(1);
        root_col = nz_cols(1);

        labeled = CC_DFS_student(bimage, root_row, root_col, label, labeled);

        num_components = num_components + 1;
        label = label + 1;
    end
end

