function run_detection( image_file )
%RUN_DETECTION Run the sudoku puzzle detection algorithm on an image of the
%puzzle contained in image_file. Then display the results in a GUI.

fprintf('Running detection on %s\n', image_file);

MAX_IMAGE_SIZE = 800;
BW_THRESHOLD = 0.65;

rgb_img = imread(image_file);
rgb_img = im2double(rgb_img);

% If the image is too big, downsample it
if size(rgb_img, 1) > MAX_IMAGE_SIZE || size(rgb_img, 2) > MAX_IMAGE_SIZE
    fprintf('Image too big: ');
    if size(rgb_img, 1) > size(rgb_img, 2)
        fprintf('Scaling height to %d...', MAX_IMAGE_SIZE);
        rgb_img = imresize(rgb_img, [MAX_IMAGE_SIZE, NaN]);
    else
        fprintf('Scaling width to %d...', MAX_IMAGE_SIZE);
        rgb_img = imresize(rgb_img, [NaN, MAX_IMAGE_SIZE]);
    end
    fprintf('Done\n');
end

img = rgb_img;

% Convert to grayscale if necessary
if size(img, 3) > 1
    img = rgb2gray(img);
end

% Invert color (since the interesting characters are in black)
img = 1 - img;

% Threshold the image
img = im2bw(img, BW_THRESHOLD);

fprintf('Deskewing...');
angle = get_alignment_angle(img);
img = imrotate(img, angle, 'bilinear');
rgb_img = imrotate(rgb_img, angle, 'bilinear');
fprintf('Done\n');

[fonts, numbers] = read_fontfaces();
pref_digit_mat = get_preferred_digit_matrix();
sudoku_mat = match_characters(img, rgb_img, false, fonts, numbers, pref_digit_mat);
show_sudoku_matrix(sudoku_mat);
end

