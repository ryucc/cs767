## CS767 Assignment 1

### Problem 1
#### 1.1 mySegmenter(imIn) 
   - Segmentate the image into foreground and background.
   - Inputs : A 2-D logical or integer array, the image.
   - Outputs : 
    - imOut : The Segmentated image
    - bdd\_points : A polygon boundary of the image.
	- bdd\_length: 
   - Algorithm: Generates a histrogram on the image, then uses Otsu's method to find threshold for segmentation.
#### []myPerimeter(imIn): Find an polygon boundary that surrounds the foreground pixels.
   - Inputs: A 2-D logical array, the foreground pixels.
   - Outputs : A array of x-y coordinates in counter-clockwise order on the boundary.
   - Algorithm: for every x, put the pixel with max y and min y pixel on the boundary.

 - myArea.m(boundary):  
   - Inputs: A array of order points on the boundary.
   - Outputs: A scalar, the area.
   - Algorithm: Divides the area into triangles, calculate the directed area for each triangle, return the absolute value of the sum.
