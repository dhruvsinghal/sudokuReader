function labeled = CC_DFS_student(bimage, root_row, root_col, label, labeled)
% Run DFS to label a single connected component of an image.  When this
% function is finished, the matrix 'labeled' should have the value 'label'
% for every pixel that is in the same component of bimage as the pixel at 
% (root_row, root_col).
%
% Inputs: 
%    bimage: the thresholded binary image
%    root_row, root_col: the row and column of the root node
%    label:   the label that every pixel in this component should be given
%
% Outputs:
%    labeled: the matrix that should be properly labeled on exit

    s = newLinkedList();
    s = stackPush(s, root_row, root_col); % Start wih the root pixel
    
    while ~listIsEmpty(s)
        [r, c] = stackPeek(s);
        labeled(r, c) = label;
        [nextR, nextC] = explore(bimage, labeled, r, c);
        
        if nextR ~= r || nextC ~= c % Check if it is not a terminal node
            s = stackPush(s, nextR, nextC);
        else
            [~, ~, s] = stackPop(s);
        end  
    end
end

function valid = explorable(bimage, labeled, r, c)
% This function checks if a prospective pixel is valid and unexplored
%
% Returns true iff:
% (1) r and c lie in bimage
% (2) pixel at (r, c) is white
% (3) pixel at (r, c) is not labeled

    [nr, nc] = size(bimage);
    valid = r > 0 && r <= nr && c > 0 && c <= nc ... Check bounds
                  && bimage(r, c)       ... % Check if it's white
                  && ~labeled(r, c);  % Check if it's not labeled
end

function [r, c] = explore(bimage, labeled, r, c)
% This function returns the location of next 'explorable' pixel,
% or returns the same r and c if (r, c) is a terminal pixel.

    if explorable(bimage, labeled, r-1, c)
        r = r - 1;
    elseif explorable(bimage, labeled, r+1, c)
        r = r + 1;
    elseif explorable(bimage, labeled, r, c-1)
        c = c - 1;
    elseif explorable(bimage, labeled, r, c+1)
        c = c + 1;
    end
end