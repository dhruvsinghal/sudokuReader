function trimmed_img = largest_component( image )
%LARGEST_TRIMMED_COMPONENT Returns an image made up of the largest
%connected component in the image

[labeled_image, n_labels] = bwlabel(image);

largest_label = 1;
label_count = length(find(labeled_image == 1));

for i = 2 : n_labels
    count = length(find(labeled_image == i));
    if count > label_count
        label_count = count;
        largest_label = i;
    end
end

trimmed_img = labeled_image == largest_label;

end

