function is_valid = is_matrix_valid(matrix)
%IS_MATRIX_VALID Return true if the sudoku matrix is valid, or false
%otherwise

is_valid = true;

for i = 1 : 9
    if ~is_valid_vector(matrix(:, i))
        is_valid = false;
        warning('MAT_TEST:ColTest','Failed on col %d', i);
        break;
    end

    if ~is_valid_vector(matrix(i, :))
        is_valid = false;
        warning('MAT_TEST:RowTest','Failed on row %d', i);
        break;
    end
    
    row_start = (floor((i-1) / 3))*3 + 1;
    row_end = row_start + 2;
    col_start = (mod((i-1), 3))*3 + 1;
    col_end = col_start + 2;
    
    if ~is_valid_vector(matrix(row_start:row_end, col_start:col_end))
        is_valid = false;
        warning('MAT_TEST:BlockTest','Failed on block %d', i);
        break;
    end
end
end

function val = is_valid_vector(vec)
nz_vec = vec(vec > 0);
if length(unique(nz_vec)) < length(nz_vec)
    val = false;
else
    val = true;
end
end