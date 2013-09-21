function [best_match, best_orien] = find_char(test_img, fonts, numbers, ...
                                                        oriented, pref_mat)
% Detect a character from the font set, in the given subimage. Return the
% numeric value of the character and the orientation for which it was
% detected (basically, the orientation of maximum correlation with 'value')

% Holds the maximum intensity of each digit
intensities(1:9) = -1;

% Holds the orientation of each digit for which the intensity is maximum
orien = zeros(1, 9);

for i = 0 : 3
    img = imrotate(test_img, 90 * i, 'bilinear');
    for j = 1 : length(numbers)
        % Scale the sample image to match the font image
        img = imresize(img, size(fonts{j}));
    
        % Apply normalized cross correlation
        x = normxcorr2(fonts{j}, img);
        % The max intensity in the whole image is the intensity we want
        inten = max(max(x));
        num = numbers(j);
        if inten > intensities(num)
            intensities(num) = inten;
            orien(num) = i;
        end
    end
    if oriented % just one iteration
        break;
    end
end

%Just 9 values, and we need the 3 highest ones, so sorting shouldn't be a
%performance issue.
[inten, vals] = sort(intensities, 'descend');

%One and seven are such sime shapes that they match almost any other digit
%so if either of them comes out as a second closest match, we should use
%the third match as the second closest
if vals(2) == 1 || vals(2) == 7
    vals(2) = vals(3);
    inten(2) = inten(3);
end

diff = inten(1) - inten(2);
best_match = vals(1);

best_orien = orien(vals(1));
if diff < pref_mat(vals(1), vals(2), 1) ...
   && pref_mat(vals(1), vals(2), 2) == vals(2)
    best_match = vals(2); 
    best_orien = orien(vals(2));
end
end