function sudoku_mat = match_characters(image, disp_img, oriented, fonts,... 
                      numbers, pref_digit_mat, left, right, top, bottom)
%MATCH_CHARACTERS Given an image, try to match the numbers 1-9
%with the 81 segments in the sudoku puzzle. Return the matching
%sudoku matrix with the blanks set to a value < 1.
%
%If the parameter 'oriented' is true, it is assumed that the image is 
%already oriented correctly. Therefore, just one round of matching 
%(as opposed to 4, in case of non-oriented images) is performed.
%
%The cell array 'fonts' should hold images of template characters. The
%corresponding elements in the array 'numbers' should indicate the
%corresponding number in the 'fonts' array.
%
%The matrix 'pref_digit_mat' is a matrix that lists the digit to be
%preferred in case of a close match between two characters. See
%get_preferred_digit_matrix() for more details.
%
%The optional parameters 'left', 'right', 'top' and 'bottom' may be
%supplied if the image is oriented. In that case, the grid box detection is
%not performed and the given values are used instead.

BORDER_REMOVAL_RATIO = 0.10;

% This offset reduces the dimensions of a cell in order to account for
% gird-lines that might interfere with character detection.
OFFSET = 1; % pixels

if nargin < 7 % did not specify the grid box
    
    % This is the actual borders of actual grid after accounting for noise
    % outside it. Note that it is assumed to be a rectangle.
    fprintf('Computing grid boundaries...');
    [left, right, top, bottom] = get_grid_borders(image);
    fprintf('Done\n');
    
end

% The expected dimensions of a single cell in the grid including any border
box_height  = (bottom - top) / 9; % real number
box_width   = (right - left) / 9; % real number

% The dimensions of a single cell less an offset (which accounts for a
% border)
true_height = floor(box_height - 2 * OFFSET); % integer
true_width  = floor(box_width  - 2 * OFFSET); % integer

sudoku_mat = zeros(9, 9);

% To be able to track the progress and to check if the algorithm is
% running correctly, display the image, which would be overlaid with
% boxes that would highlight the 'boxes'
if oriented
    set(gcf, 'name', 'Oriented');
    clf;
else
    figure('NumberTitle', 'off');
    set(gcf, 'name', 'Non-oriented (Raw)');
end
% Supress the 'image is too big to fit on the screen' warning
warning('off', 'all');
imshow(disp_img);
warning('on', 'all');

hold on;
axis off;

rec = rectangle('Position', [left top right-left bottom-top]);
set(rec, 'EdgeColor','cyan','LineWidth', 2); % Green = found a number


% Keep track of the most probable orientation returned for each cell
orien = zeros(1, 81);
orien_count = 1;

fprintf('Analyzing row...');

for i = 1 : 9
    fprintf('\b\b\b %d...', i);
    row_top    = floor(top + box_height * (i - 1) + OFFSET); % integer
    row_bottom = row_top + true_height; % integer
    
    for j = 1 : 9
        col_left  = floor(left + box_width * (j - 1) + OFFSET); % integer
        col_right = col_left + true_width; % integer
        
        
        % Draw the boundary of the current 'box'
        rec = rectangle('Position', [col_left row_top true_width true_height]);
        set(rec, 'EdgeColor', 'g','LineWidth', 2); % Green = found something
        % Force immediate drawing of the previous rectangle
        drawnow;
        
        
        % This is the 'box' under consideration
        subimage = image(row_top:row_bottom, col_left:col_right);
        subimage = clean_border(subimage, BORDER_REMOVAL_RATIO);
        
        if ~is_mostly_empty(subimage)
            % Retain only the largest component and also trim it
            subimage = trim_border(largest_component(subimage));
            [sudoku_mat(i, j), orn] = find_char(subimage, fonts, numbers,...
                oriented, pref_digit_mat);
            
            % We should consider only those numbers for orienting the image
            % which are not (roughly) invariant under 180 degree rotation
            % (1, 8, 6, 9 are not valid)
            if sudoku_mat(i, j) ~= 1 && sudoku_mat(i, j) ~= 8  ...
                    && sudoku_mat(i, j) ~= 6 && sudoku_mat(i, j) ~= 9
                orien(orien_count) = orn;
                orien_count = orien_count + 1;
            end
        else
            set(rec, 'EdgeColor','r','LineWidth', 2); % Red = empty box
            drawnow;
        end
    end
end

fprintf('Done\n');

%Trim the orientation array (since we don't care about empty boxes)
orien = orien(1:orien_count - 1);

%If the image was not oriented, chances are that some characters, like
%9 and 6 might have been wrongly detected. To correct this, first find
%the modal (most frequent) orientation, then rotate the image accordingly.
%Then re-run this function but with a fixed orientation and use its output.
if ~oriented
    angle = 90 * mode(orien);
    if angle ~= 0
        fprintf('Rotating by %d. Re-running match with fixed orientation.\n', angle);
        image = imrotate(image, angle, 'bilinear');
        disp_img = imrotate(disp_img, angle, 'bilinear');
        sudoku_mat = match_characters(image, disp_img, true, fonts, ...
            numbers, pref_digit_mat);
    else
        fprintf('Re-running match with fixed orientation.\n');
        sudoku_mat = match_characters(image, disp_img, true, fonts, ...
            numbers, pref_digit_mat, left, right, top, bottom);
    end
end
end