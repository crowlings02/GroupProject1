%% Upper Body Detection
%% Body Detection
% This section of code was written by both Caitlin & Alexis based on the
% Matlab computer vision toolbox. Finding this toolbox and algorithm took 
% 3 hours. Doing the written code itself took 1 hour, with not a
% significant amount of time of debugging.

%Initialize body detector 
bodyDetector = vision.CascadeObjectDetector('UpperBody'); 
bodyDetector.MinSize = [60 60];
bodyDetector.MergeThreshold = 10;

%Read image and run detector, storing bounding box of the upper body
Image = imread('stripeShirt.jpg');
bboxBody = bodyDetector(Image);

% Label bounding box and show image
IBody = insertObjectAnnotation(Image,'rectangle',bboxBody,'Upper Body');
figure
imshow(IBody)
title('Detected upper bodies');

%% Color Determination
% This section was worked on by both Alexis and Caitlin. Caitlin was 
% responsible for the getColorArray, getHSVarray functions 
% while Alexis was responsible for the rest of the code. See functions for
% hour details. The non-function code took 3 hours to code and another 3 to
% debug, since we transferred from RGB to HSV.

% Store matrix of colors of each pixel from the bottom row of the upper body bounding box
colorArray = getColorArray(Image,bboxBody);

% Store HSV conversions of RBG color array
hsv_array = getHSVarray(colorArray);

% Create array to store names of colors 
colorNameArray = [];

% Loop through... 
for rx = 1:size(hsv_array, 1)
    
    % Check for Black, Gray, White with saturation and value
    if hsv_array(rx, 3) <= .1 
        color_name = 1; % Black: value is 10% or below
    
    elseif hsv_array(rx, 2) <= .15 && hsv_array(rx, 3) >= .1 && hsv_array(rx, 3) <= .9
        color_name = 2; % Gray: below 15% Sat, value between 10 and 90%
    
    elseif hsv_array(rx, 2) <= .15 && hsv_array(rx, 3) > .9
        color_name = 3; % White: below 15% Sat and above 90% value
    
    % Check for different colors using hue
    elseif hsv_array(rx, 1) >= 0 && hsv_array(rx, 1) < 25 % 0 to 25 red
        color_name = 4;
    
    elseif hsv_array(rx, 1) >= 25 && hsv_array(rx, 1) < 45 % 25 to 45 orange
        color_name = 5;
   
    elseif hsv_array(rx, 1) >= 45 && hsv_array(rx, 1) < 65 % 45 to 65 yellow
        color_name = 6;
    
    elseif hsv_array(rx, 1) >= 65 && hsv_array(rx, 1) < 170 % 65 to 170 green
        color_name = 7;
    
    elseif hsv_array(rx, 1) >= 170 && hsv_array(rx, 1) < 190 % 170 to 190 cyan
        color_name = 8;
    
    elseif hsv_array(rx, 1) >= 190 && hsv_array(rx, 1) < 260 % 190 to 260 blue
        color_name = 9;
    
    elseif hsv_array(rx, 1) >= 260 && hsv_array(rx, 1) < 290 % 260 to 290 purple
        color_name = 10;
    
    elseif hsv_array(rx, 1) >= 290 && hsv_array(rx, 1) <= 340 % 290 to 340 pink
        color_name = 11;
    
    elseif hsv_array(rx, 1) > 340 && hsv_array(rx, 1) <= 360 % 340 to 360 red
        color_name = 4;
    end  
    
    % Store 'color names' by numerical assignment corresponding to color
    % positions created below
    colorNameArray = [colorNameArray, color_name];
end

%% Find Most Frequent Colors 
% This section of code was written by Alexis and debugged by both Caitlin
% and Alexis. Writing the code itself took 3 hours, with 3 hours of
% debugging due to various issues of sorting strings and characters.

% Vector that stores frequency of each color corresponding to color_positions (see below)
count_color = zeros(1,11);

%Increment color frequencies by each color value in color array
for ii = 1:size(colorNameArray, 2)
    if colorNameArray(ii) == 1
        count_color(1) = count_color(1) + 1;
    
    elseif colorNameArray(ii) == 2
        count_color(2) = count_color(2) + 1;
    
    elseif colorNameArray(ii) == 3
        count_color(3) = count_color(3) + 1;
    
    elseif colorNameArray(ii) == 4
        count_color(4) = count_color(4) + 1;
    
    elseif colorNameArray(ii) == 5
        count_color(5) = count_color(5) + 1;
    
    elseif colorNameArray(ii) == 6
        count_color(6) = count_color(6) + 1;
    
    elseif colorNameArray(ii) == 7
        count_color(7) = count_color(7) + 1;
    
    elseif colorNameArray(ii) == 8
        count_color(8) = count_color(8) + 1;
    
    elseif colorNameArray(ii) == 9
        count_color(9) = count_color(9) + 1;
    
    elseif colorNameArray(ii) == 10
        count_color(10) = count_color(10) + 1;
    
    elseif colorNameArray(ii) == 11
        count_color(11) = count_color(11) + 1;  
    end
end

%Find first maximum color
max = count_color(1);
%if current greater than previoius, reset max # of color occurences
for jj = 2:11
   if count_color(jj) > max
        max = count_color(jj); % cant set max = index just in case there is a tie
   end
end

% Create vector of colors that tie for highest frequency (max & max2)
max_index = [];

% Creates new vector that stores frequencies of each color that matches max
% frequency (and 2nd max)
for kk = 1:11
    if count_color(kk) == max
        max_index = [max_index kk];
    end
end
    


%% Create output message
% This section was written by Alexis and debugged by both Caitlin and
% Alexis. It took 1 hour to code and an hour to debug.

message = '';

% Vector storing color positions in their specified indices
color_positions = ["black" "gray" "white" "red" "orange" "yellow" "green" "cyan" "blue" "purple" "pink"];

% First message for most prominent color(s) 
for mm = 1:size(max_index, 2)
    % Add color to message
    if mm==size(max_index, 2)
        message = strcat(message, color_positions(max_index(mm)));
    
    % Only add "and" and second color in case of a tie
    else
        message = strcat(message, color_positions(max_index(mm)), 'and ');
    end
end

% Create final message output
final_message = strcat('The most prominent shirt color(s) is/are ', {' '}, message);
disp(final_message);

