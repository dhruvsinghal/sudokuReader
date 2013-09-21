function list = listDeleteAtEnd(list)
% Delete the last element of a linked list
    
    enforceListConstraints(list);
    
    if list(1) == 0 % If the list is empty
        return
    end
    
    if list(3) == 1 % Only one element in the list
        
        list = deleteListCell(list, list(1));
        
        list(1) = 0; % No first element
        list(2) = 0; % No last element
        list(4) = 5; % First free node is right after the header    
    
    else
        oldLast = list(2);
        secondLast = list(oldLast);
        
        list = deleteListCell(list, oldLast); % Release the last node
        
        list(secondLast + 3) = 0; % Remove reference to the last node
        list(2) = secondLast;
    end
    
    enforceListConstraints(list);
end