function list = listInsertAtEnd(list, row, col)
% Insert an element x at the end of the list, and return the new list

    enforceListConstraints(list);
    
    [cell, list] = getNewListCell(list);
    
    oldLast = list(2);
    
    list(cell) = oldLast;   % Set cell's previous pointer
    list(cell + 1) = row;   % Assign row
    list(cell + 2) = col;   % Assign column
    list(2) = cell;         % Make cell the last node
    
    if oldLast == 0         % If the list was empty
        list(1) = cell;     % Make cell the first element too
    else
        list(oldLast + 3) = cell; % Make the previous last element point to cell
    end   
    
    enforceListConstraints(list);
end
