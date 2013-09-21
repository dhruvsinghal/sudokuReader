function [row, col, stack] = stackPop(stack)
% Get the last element from the stack and remove it
% Returns row=0 and col=0 in case of underflow

    if stack(3) == 0 % Underflow
        error('Underflow: Stack is empty.');
    end

    first = stack(1);

    row = stack(first + 1);
    col = stack(first + 2);

    stack = listDeleteAtStart(stack);

end
