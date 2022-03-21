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
colorArray = getColorArray(I2,bboxBody);

% for c = 1:size(colorArray,2)
% colorNameArray = fuzzycolor(colorArray(:,c)');
% end

% isc = fuzzycolor(colorArray','neutral')>0.5;
% figure
% displaycolorpatches(colorArray(isc,:))


figure
displaycolorpatches(colorArray')

%   Columns 1 through 8
%    1'red' 2'green' 3'blue' '4neutral' 5'pastel' 6'yellow' 7'flesh' 8'cyan'
%   Columns 9 through 13
%     9'magenta' 10'black' 11'white' 12'purple' 13'brown'


