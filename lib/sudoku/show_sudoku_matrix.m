function show_sudoku_matrix( sudoku_matrix )
%SHOW_SUDOKU_MATRIX Display the 'sudoku_matrix' in a 9x9 GUI grid.

f = figure('name', 'Sudoku Puzzle');
set(f, 'Position', [5 350 350 350]);
set(f, 'NumberTitle', 'off');
t = uitable;
mat = cell(9, 9);
mat(sudoku_matrix ~= 0) = num2cell(sudoku_matrix(sudoku_matrix ~= 0));
set(t, 'data', mat);
set(t, 'columnwidth', {25});
set(t, 'columnname', {});
set(t, 'rowname', {});
set(t, 'FontSize', 16);

end

