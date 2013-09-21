function [index, list] = getNewListCell(list)
% Returns the index of a new list cell
    
    % Scan the list for the new free index
    index = list(4);

    if index > length(list)
        error('Linked list is out of memory.\n');
    end

    nextFree = list(index + 3); % Get the pointer to the next free node
    
    list(index + 3) = 0; % Clear the pointer

    if nextFree == 0 % If this wasn't a 'used' block
        nextFree = index + 4; % The next block must be right after this one
    end

    list(4) = nextFree; % Update the free list pointer
    
    list(3) = list(3) + 1; % Update the size