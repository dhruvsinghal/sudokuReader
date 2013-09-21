function test_labeled( )

img = imread('sudoku-noisy-rotated.jpg');
%img = imread('sudoku1.png');
img = im2double(img);
if size(img, 3) > 1
img = rgb2gray(img);
end
img(img > 0.5) = 1;
img(img <= 0.5) = 0;
img = ~img;

[lbl, n] = connected_components(img);
l2 = remove_noise(lbl,n, 3);
imshow(l2);
end

