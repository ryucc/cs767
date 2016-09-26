### CS767 Assignment 1

## Problem 1
 - mySegmenter.m: Segmentate the image into foreground and background.
   - Algorithm: Generates a histrogram on the image, then uses Otsu's method to find threshold for segmentation.
   - Returns : A logical 2-D array, True for pixels on the foreground.
 - myPerimeter.m: Find an polygon boundary that surrounds the foreground pixels.
   - Algorithm: for every x, put the pixel with max y and min y pixel on the boundary.
   - Returns : A array of x-y coordinates in counter-clockwise order on the boundary.
 - myArea.m:  
   - Algorithm: Divides the area into triangles, calculate the directed area for each triangle, return the absolute value of the sum.
   - Returns: A scalar, the area.
