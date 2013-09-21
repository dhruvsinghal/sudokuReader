function angle = get_alignment_angle( bimage )
%FIX_ROTATION Return an angle such than on rotating bimage by this angle, 
%the rectangular grid would align with the horizontal and vertical 
%directions of the reference plane.

%Only consider the edges because thick borders may interfere with the angle
%detection
img_edge = edge(bimage, 'canny');

%Run Hough tranformation to detect all the lines in the angle interval (in
%degrees) [MIN_ANGLE, MAX_ANGLE) with a step size of ANGLE_STEP.

MIN_ANGLE = -45;
MAX_ANGLE = 45;
ANGLE_STEP = 0.5;

[H, theta, ~] = hough(img_edge, 'theta', MIN_ANGLE : ANGLE_STEP : ...
                                            MAX_ANGLE-ANGLE_STEP);
                                        
%Extract the details of the line with the highest peak
V = houghpeaks(H, 1);

%The required angle is the theta of that peak (we ignore rho).
angle = theta(V(2));
end

