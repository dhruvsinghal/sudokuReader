function [font_images, numbers] = read_fontfaces()
%READ_FONTFACES Return a cell array of template images of the digits 1-9
%from a default directory. Also return a vector with elements that
%corresponds to the numbers that the images represent.

font_files = dir('/Users/dhruv17singhal/Documents/MATLAB/cs1114/Final/templates/font*_*.*');

n_files = length(font_files);

font_images = cell(1, n_files);
numbers = zeros(1, n_files);

for i = 1 : n_files
    font_images{i} = read_font(font_files(i).name);
    numbers(i) = get_font_number(font_files(i).name);
end
end

function img = read_font(filename)
%Read the specified image, threshold it, and trim its borders
img = imread(filename);
img = im2double(img);
img = imcomplement(img);
img = im2bw(img, 0.9);
img = trim_border(img);
end

function val = get_font_number(filename)
%Every font filename is of the format fontX_Y.*
%X = a font serial number and Y = the digit represented
%This function returns Y.
[~, filename, ~] = fileparts(filename);
num_start_index = max(strfind(filename, '_'));
digit_string = filename(num_start_index + 1 : end);
val = str2double(digit_string);
end