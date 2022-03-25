# GroupProject1
CLPS 0950 Computer Vision: What Color is the Shirt

README
Important notes:
We had issues setting up github in the first week, and Alexis' computer
also was broken for a brief period of time, so it was a bit difficult to
log most of our initial hours and work responsibilities, so I will do so
in the README

Input Image:
Accepts frontal full-body images, no hair in face
SOLID shirt color OR Vertical stripes OR florals/designs with a base color


GetShirtColor.m: General code
Includes:
getColorArray.m: generates array of pixels from upper-body detection code
GetHSVarray.m: determines color of each pixel and stores in new array
GetShirtColor.m: Finds prominent color from HSVarray

Basic overview:

Uses CascadeObjectDetector to detect upper body of frontal-facing, full-body images
Isolates bottom row of pixels of upper-body matrix→ detects and stores the hsv values for each pixel in a new array
Bottom row is representative of shirt and likely does not include skin color from cut→ sides of matrix are usually fit to shoulder width and include few outliers from the background
Uses hue, saturation, and value to estimate a color for each pixel
Stores frequencies of each color in order to determine most prominent color

Breakdown of Hours:
5 hours each of researching datasets, algorithms, and brainstorming how we will approach the problem.
1 hours each testing Cascade Detector Algorithm on face detection
1 hours Figure out how to upper body shirt sample + code
2 hours each Determine where/how we will get a shirt sample & coding
5 hours determining how to get shirt color from upper body
3 hours coding determining what is most prominent color
1 hour of coding output messages
4 hours debugging color
3 hour integrating,commenting, testing different images & README

All debugging, testing, integration, and planning was done together. Much of the code, particularly relating to categorizing color (and meeting with Ivan) was done together.
Individually-coded portions:
Cascade detection algorithm, fitting into our code → Caitlin
Acquiring shirt sample matrix and isolating bottom array → Caitlin
Color frequency and prominent color → Alexis
Final message → Alexis

![ShirtColorDemo_AdobeCreativeCloudExpress](https://user-images.githubusercontent.com/77941819/160040527-8e170732-2db5-4044-bf81-328a78a0ef15.gif)
