function list = listDeleteAtStart(list)
% Delete the first element in a linked list

    enforceListConstraints(list);
    
    first = list(1);

    if list(3) == 0 % Check if the list is empty
        return; % Nothing to delete
    end
    
    if list(3) == 1  % Only one element
        list(1) = 0; % No first element
        list(2) = 0; % No last element
        
    elseif list(3) == 2 % Only one element would be left after deletion
        second = list(first + 3);
        list(1) = second; % Change the headers to point to the 2nd element
        list(2) = second;
    else
        list(1) = list(first + 3);
    end
    
    list = deleteListCell(list, first);
    
    enforceListConstraints(list);
end