function [row, col] = stackPeek(stack)
% Returns the last element from the stack and but DOES NOT REMOVE IT.
% Returns row=0 and col=0 in case of underflow.

    if stack(3) == 0 % Underflow
        error('Underflow: Stack is empty.');
    end

    first = stack(1);

    row = stack(first + 1);
    col = stack(first + 2);

end
