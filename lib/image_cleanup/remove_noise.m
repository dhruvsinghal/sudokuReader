function clean_image = remove_noise(labeled_image, label_count, thresh)
%REMOVE_NOISE Given a binary 'labeled_image' such that cells with the same
%integer value are part of the same connected component (and 0 indicating a
%no component), return a 'clean_image' that has all the connected
%components with pixel count less than 'thresh' are set to zero.

clean_image = labeled_image;

for i = 1 : label_count
    locations = find(labeled_image == i);
    count = length(locations);
    if count >= thresh
        clean_image(locations) = 1;
    else
        clean_image(locations) = 0;
    end
end

end

