%% Upper Body Detection

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



% figure
% displaycolorpatches(colorArray')

%   Columns 1 through 8
%    1'red' 2'green' 3'blue' '4neutral' 5'pastel' 6'yellow' 7'flesh' 8'cyan'
%   Columns 9 through 13
%     9'magenta' 10'black' 11'white' 12'purple' 13'brown'

% 25 to 45 orange
% 45 to 65 yellow
% 65 to 170 green
% 170 to 190 cyan
% 160 to 260 blue
% 260 to 290 purple
% 290 to 340 pink
% 340 to 360 red
% 0 to 25 red
% Black: value is 10% or below
% Gray: below 15% Sat, value between 10 and 90%
% White: below 15% Sat and above 90% value

hsv_array = getHSVarray(colorArray)

ColorNameArray = [];
for rx = 1:size(hsv_array, 1)
if hsv_array(rx, 3) <= .1
    color_name = 'Black';
elseif hsv_array(rx, 2) <= .15 && hsv_array(rx, 3) >= .1 && hsv_array(rx, 3) <= .9
    color_name = 'Gray';
elseif hsv_array(rx, 2) <= .15 && hsv_array(rx, 3) > .9
    color_name = 'White';
elseif hsv_array(rx, 1) >= 0 && hsv_array(rx, 1) < 25
    color_name = 'Red';
elseif hsv_array(rx, 1) >= 25 && hsv_array(rx, 1) < 45
    color_name = 'Orange';
elseif hsv_array(rx, 1) >= 45 && hsv_array(rx, 1) < 65
    color_name = 'Yellow';
elseif hsv_array(rx, 1) >= 65 && hsv_array(rx, 1) < 170
    color_name = 'Green';
elseif hsv_array(rx, 1) >= 170 && hsv_array(rx, 1) < 190
    color_name = 'Cyan';
elseif hsv_array(rx, 1) >= 190 && hsv_array(rx, 1) < 260
    color_name = 'Blue';
elseif hsv_array(rx, 1) >= 260 && hsv_array(rx, 1) < 290
    color_name = 'Purple';
elseif hsv_array(rx, 1) >= 290 && hsv_array(rx, 1) <= 340
    color_name = 'Pink';
elseif hsv_array(rx, 1) > 340 && hsv_array(rx, 1) <= 360
    color_Name = 'Red';
end  
    ColorNameArray = [ColorNameArray, color_name]
end

