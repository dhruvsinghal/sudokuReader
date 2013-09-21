function test_matrix_validity()

mat = [8 0 0 4 0 6 0 0 7;
       0 0 0 0 0 0 4 0 0;
       0 1 0 0 0 0 6 5 0;
       5 0 9 0 3 0 7 8 0;
       0 0 0 0 7 0 0 0 0;
       0 4 8 0 2 0 1 0 3;
       0 5 2 0 0 0 0 9 0;
       0 0 1 0 0 0 0 0 0;
       3 0 0 9 0 2 0 0 5];
   
if ~(is_matrix_valid(mat))
    error('Failed on matrix 1');
end
   
mat = [0 5 0 7 0 0 0 0 8;
       0 0 3 0 5 4 0 7 0;
       2 0 9 3 0 0 5 0 4;
       0 0 5 1 0 2 4 0 0;
       3 4 0 0 0 0 0 0 7;
       0 0 1 4 3 0 9 0 5;
       0 0 2 0 0 0 0 5 6;
       0 3 0 6 0 5 8 0 2;
       5 9 0 0 2 3 0 0 0];
   
if ~(is_matrix_valid(mat))
    error('Failed on matrix 2');
end

mat = [0 5 0 7 0 0 0 0 8;
       0 0 3 0 5 4 0 7 0;
       2 0 9 3 0 0 5 0 4;
       0 0 5 1 0 2 4 0 0;
       3 4 0 0 0 0 0 0 7;
       0 0 1 4 3 0 3 0 5;
       0 0 2 0 0 0 0 5 6;
       0 3 0 6 0 5 8 0 2;
       5 9 0 0 2 3 0 0 0];
   
if is_matrix_valid(mat)
    error('Did not fail on matrix 3');
end

fprintf('\nAll tests passed.\n');

end

