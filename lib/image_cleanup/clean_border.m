function [ img ] = clean_border( img, ratio )
%CLEAN_BORDER Set the 'ratio' times the height and width of the image 'img'
%pixels at the four edges to zero.

n_width = floor(size(img, 2) * ratio);
n_height = floor(size(img, 1) * ratio);
img(1:n_height, :) = 0;
img(:, 1:n_width)  = 0;
img(end-n_height:end, :) = 0;
img(:, end-n_height:end) = 0;

end

