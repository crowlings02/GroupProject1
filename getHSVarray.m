function [HSV_Array] = getHSVarray(color_Array) 
% This function was written by Caitlin and debugged by both Alexis and 
% Caitlin. It took 2 hours to write and 2 hours to debug.
    
    % Initialize HSV_Array as a # of columns in the color array x 3 array,
    % where each row corresponds to the pixel of the image, and the 
    % three columns correspond to H(row 1), S (row 2), and V(row 3). 
    HSV_Array = zeros(size(color_Array,2),3);

    %Loop through each row of the new HSV_Array and fill it in
    for i = 1:size(HSV_Array,1)
        %Set each row as the HSV value converted from the given RGB (represented by any
        %given column in the color_Array)
        HSV_Array(i,:) = rgb2hsv(color_Array(:,i)'); 
    end

    % Multiply each H (hue) value (given by the first column) by 360 to get
    % value in degrees
    HSV_Array(:,1) = HSV_Array(:,1).*360;

end