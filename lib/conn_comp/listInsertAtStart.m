function list = listInsertAtStart(list, row, col)
% Insert an element x at the start of the list, and return the new list
    
    enforceListConstraints(list);

    % Allocate a new cell for the new element
    [index, list] = getNewListCell(list);

    % Find the index of the old first element
    first = list(1);

    % Fill in the new cell, updating its values and pointers
    list(index) = 0;        % Back pointer to the previous element (null)
    list(index+1) = row;    % Value of the row  
    list(index+2) = col;    % Value of the column
    list(index+3) = first;  % Forward pointer to the next element

    % Update back pointer for the old first element
    if first ~= 0
        % The list wasn't empty, so update the back pointer
        list(first) = index;
    else
        % The list was empty, so the first element is also the last element
        % Thus, update the header's pointer to the last element
        list(2) = index;
    end

    list(1) = index;        % update the starting index
    
    enforceListConstraints(list); 
end
