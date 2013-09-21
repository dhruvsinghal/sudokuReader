function printLinkedList(list)
% Prints a linked list from start to end

    if list(3) == 0
        fprintf('List is empty.\n');
        return
    end

    next = list(1); % First node

    arrow = false; % Don't print arrow the first time

    while next > 0

        if arrow
            fprintf(' -> ');
        else
            arrow = true; % Print arrow the next time
        end

        fprintf('[%d, %d]', list(next + 1), list(next + 2));

        next = list(next + 3); % Move to the next node
    end
    
    if list(1) > 0 % List is not empty
        fprintf('\n'); % Something was printed so change line
    end
end