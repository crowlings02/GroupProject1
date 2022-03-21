function [colorArray] = getColorArray(image, bbox)
% getColorArray takes in an image, and the bounding box of the upper body
% detected and returns a matrix representing the colors of the last row of the bounding box.

% The matrix returned is is 3 x width of input bounding box, where each
% column represents a pixel of the last bounding box row, and each row represents
% a color channel (1: R, 2: G, 3: B)

    % Initialize colorArray as empty matrix that is 3 x bbox width
    colorArray = zeros(3,bbox(3));

    %Go through each column from 1st column (top left x pos) to last column of image (x pos + image width) 
    for c = bbox(1) : bbox(1) + bbox(3) 
            
        %For each color channel (row of new color array)
            for channel = 1 : 3 
                % Make sure color array iterates from 1-width, not the corresponding image column location
                colorCol = c-bbox(1)+1; 
                
                %Store RGB of pixel in last row (y pos + height) of corresponding image columns
                colorArray(channel,colorCol) = double(image(bbox(2)+bbox(4),c,channel))/255; 
            end    
    end
end


