function list = deleteListCell(list, index)
% Deletes the cell at index from the list
    
    if index > length(list) || index < 5
        error('Index %d is out of bounds. 0 < index <= %d.\n', index, length(list));
    end

    if mod(index, 4) ~= 1
        error('Misaligned index %d.\n', index);
    end

    % Empty the cell
    list(index) = 0;
    list(index + 1) = 0;
    list(index + 2) = 0;

    %Now update pointers to the free list
    list(index + 3) = list(4);
    list(4) = index;
    
    list(3) = list(3) - 1;