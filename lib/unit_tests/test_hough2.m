img = imread('sudoku-noisy-rotated.jpg');
%img = imread('sudoku1.png');
%img = imread('photo.jpg');
img = im2double(img);
if size(img, 3) > 1
    img = rgb2gray(img);
end
img = 1 - img;
img = im2bw(img, 0.8);

tic;
[lbl, n] = bwlabel(img, 8);
img = remove_noise(lbl,n, 6);
fprintf('Noise removal: %5.3f s\n', toc);

tic;
img = fix_rotation(img);
fprintf('Fix Rotation: %5.3f s\n', toc);

ker1 = [0 0 1 1 1 0 0;
        0 0 1 1 1 0 0;
        1 1 1 1 1 1 1;
        1 1 1 1 1 1 1;
        1 1 1 1 1 1 1;
        0 0 1 1 1 0 0;
        0 0 1 1 1 0 0];

imgcon = conv2(img, ker1, 'same') >= 18;
img = largest_component(img & imgcon);
imshow(img);