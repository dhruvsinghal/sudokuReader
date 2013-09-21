function list = newLinkedList()
% Returns an array that can be used as a linked list (of positive numbers)
list = zeros(1, 80000);
list(1) = 0; % Pointer to start
list(2) = 0; % Pointer to end
list(3) = 0; % Size of list
list(4) = 5; % Pointer to first free cell
