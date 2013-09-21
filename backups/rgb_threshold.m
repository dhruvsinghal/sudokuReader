function bimage = rgb_threshold( rgb_image, r, g, b )
%RGB_THRESHOLD Return a binary image such that its bright pixels map to
%those pixels in the rgb_image which have their red, green and blue
%components less than 'r', 'g', and 'b' respectively.

bimage = rgb_image(:,:,1) < r & rgb_image(:,:,2) < g & rgb_image(:,:,3) < b;

end

