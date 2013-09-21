function mat = get_preferred_digit_matrix()
%GET_PREFERRED_CHAR Return a matrix 'mat' such that given two numbers i 
%and j, mat(i, j, 1) returns the maximum value of the difference in 
%normalized cross-correlation peaks, that would regard the i and j as a
%close-match pair, and mat(i, j, 2) returns the number that is to be
%preferred in case of a close match.

mat = zeros(9, 9, 2);

% Default threshold
mat(:, :, 1) = 0.10;

mat = add_to_mat(mat, 1, 2, 2);
mat = add_to_mat(mat, 1, 3, 3, 0.20);
mat = add_to_mat(mat, 1, 4, 4, 0.05);
mat = add_to_mat(mat, 1, 5, 5, 0.25);
mat = add_to_mat(mat, 1, 6, 6, 0.25);
mat = add_to_mat(mat, 1, 7, 7, 0.01);
mat = add_to_mat(mat, 1, 8, 8, 0.20);
mat = add_to_mat(mat, 1, 9, 9);

mat = add_to_mat(mat, 3, 5, 3);
mat = add_to_mat(mat, 2, 5, 2, 0.2);

mat = add_to_mat(mat, 4, 5, 4);
mat = add_to_mat(mat, 4, 7, 4);
mat = add_to_mat(mat, 4, 8, 4);
mat = add_to_mat(mat, 4, 9, 4, 0.05);

mat = add_to_mat(mat, 5, 6, 6, 0.05);

mat = add_to_mat(mat, 7, 2, 2, 0.20);
mat = add_to_mat(mat, 7, 3, 3, 0.20);
mat = add_to_mat(mat, 7, 4, 4);
mat = add_to_mat(mat, 7, 5, 5, 0.20);
mat = add_to_mat(mat, 7, 6, 6, 0.20);
mat = add_to_mat(mat, 7, 8, 8, 0.20);
mat = add_to_mat(mat, 7, 9, 9);

end

function mat = add_to_mat(mat, digit1, digit2, pref_digit, thresh)
%ADD_TO_MAT Add 'digit1' and 'digit2' to 'mat' symmetrically, with
%'pref_digit' set as the preferred digit and, optionally, set the
%maximum threshold for match to 'thresh'
if pref_digit ~= digit1 && pref_digit ~= digit2
    error('Preferred digit must be one of the two close-match digits');
end
if nargin > 4
    mat(digit1, digit2, 1) = thresh;
    mat(digit2, digit1, 1) = thresh;
end
mat(digit1, digit2, 2) = pref_digit;
mat(digit2, digit1, 2) = pref_digit;
end