%% Upper Body Detection
%% Body Detection

%Initialize body detector 
bodyDetector = vision.CascadeObjectDetector('UpperBody'); 
bodyDetector.MinSize = [60 60];
bodyDetector.MergeThreshold = 10;

%Read image and run detector, storing bounding box of the upper body
Image = imread('person.jpg');
bboxBody = bodyDetector(Image);

% Label bounding box and show image
IBody = insertObjectAnnotation(Image,'rectangle',bboxBody,'Upper Body');
figure
imshow(IBody)
title('Detected upper bodies');

%% Color Determination

% Store matrix of colors of each pixel from the bottom row of the upper body bounding box
colorArray = getColorArray(Image,bboxBody);

% Store HSV conversions of RBG color array
hsv_array = getHSVarray(colorArray);

% Create array to store names of colors 
%% TODO: Initialize with given size since we know how long it will be?
ColorNameArray = [];

% Loop through... 
for rx = 1:size(hsv_array, 1)
    
    % Check for Black, Gray, White with saturation and value
    if hsv_array(rx, 3) <= .1 
        color_name = 'Black'; % Black: value is 10% or below
    
    elseif hsv_array(rx, 2) <= .15 && hsv_array(rx, 3) >= .1 && hsv_array(rx, 3) <= .9
        color_name = 'Gray'; % Gray: below 15% Sat, value between 10 and 90%
    
    elseif hsv_array(rx, 2) <= .15 && hsv_array(rx, 3) > .9
        color_name = 'White'; % White: below 15% Sat and above 90% value
    
    % Check for different colors using hue
    elseif hsv_array(rx, 1) >= 0 && hsv_array(rx, 1) < 25 % 0 to 25 red
        color_name = 'Red';
    
    elseif hsv_array(rx, 1) >= 25 && hsv_array(rx, 1) < 45 % 25 to 45 orange
        color_name = 'Orange';
   
    elseif hsv_array(rx, 1) >= 45 && hsv_array(rx, 1) < 65 % 45 to 65 yellow
        color_name = 'Yellow';
    
    elseif hsv_array(rx, 1) >= 65 && hsv_array(rx, 1) < 170 % 65 to 170 green
        color_name = 'Green';
    
    elseif hsv_array(rx, 1) >= 170 && hsv_array(rx, 1) < 190 % 170 to 190 cyan
        color_name = 'Cyan';
    
    elseif hsv_array(rx, 1) >= 190 && hsv_array(rx, 1) < 260 % 190 to 260 blue
        color_name = 'Blue';
    
    elseif hsv_array(rx, 1) >= 260 && hsv_array(rx, 1) < 290 % 260 to 290 purple
        color_name = 'Purple';
    
    elseif hsv_array(rx, 1) >= 290 && hsv_array(rx, 1) <= 340 % 290 to 340 pink
        color_name = 'Pink';
    
    elseif hsv_array(rx, 1) > 340 && hsv_array(rx, 1) <= 360 % 340 to 360 red
        color_Name = 'Red';
    end  
    
    % whatver
    ColorNameArray = [ColorNameArray, color_name];

end

