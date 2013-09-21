function bimage = trim_border( bimage )
%TRIM_BORDER Trim the image to make it only as large as the bounding box
%for its enclosed pixels.
[rows, cols] = find(bimage);
first_row = min(rows);
last_row = max(rows);
first_col = min(cols);
last_col = max(cols);

bimage = bimage(first_row:last_row, first_col:last_col);

end

