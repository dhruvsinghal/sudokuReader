img = imread('sudoku-noisy-rotated.jpg');
%img = imread('sudoku1.png');

img = im2double(img);
if size(img, 3) > 1
img = rgb2gray(img);
end

img(img > 0.5) = 1;
img(img <= 0.5) = 0;
img = ~img;

tic;
[lbl, n] = bwlabel(img, 8);
img = remove_noise(lbl,n, 6);
fprintf('Noise removal: %5.3f s\n', toc);

tic;
img = hough_transform_custom(img);
fprintf('Fix Rotation: %5.3f s\n', toc);

img = trim_border(img);
imshow(img);