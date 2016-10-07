## CS767 Assignment 1

### Problem 1
#### 1.1 mySegmenter(imIn) 
   - Segmentate the image into foreground and background.
   - Inputs : A 2-D logical or integer array, the image.
   - Outputs : 
    - imOut : The Segmentated image.
    - bdd\_points : A polygon boundary of the image.
    - bdd\_length: The length of the polygon boundary.
    - Area: Area inside the polygon boundary.
    - diameter: the largest distance between two points in the ROI.
   - Implementation:
    - Segmentation: Ostu's Method on the histogram.
    - boundary points: The (max\_x,y) and (min\_x,y) for every y, and fill up the gaps between boundary points. Given there is only one blob, this gives a polygon that surrounds the blob.
    - bdd\_length: The number of boundary points, sinces all boundary points are neighbors.
    - Area: The integral of (max\_x - min\_x + 1) over y
    - diameter: Runs a n^2 pairwise distances to find the diameter. Necessary because boundary is not convex. 

### 1.1 other (maybe unused) implementations
   - myPerimeter: Handles bdd\_points, bdd\_length, Area, diameter for mySegmenter.
   - myDiameter: Handles diameter for myPerimeter.
   - myArea(unused): Takes the set of boundary points, and calulates the area by dividing it into triangles.
   - myPerimeterLength(unused):the sum of Euclidian distances between boundary points.

#### 1.2 myDT(imIn,method)
   - Creates the distance transfrom
   - Inputs : A 2-D logical or integer array, the image.
   - Outputs: [A,B]
    - A: the distance map outside the boundary
	- B: the distance map inside the boundary
   - implementation:
   By default, uses BFS to calculate the mannhattan distance to the closest boundary point. If specified (method = '2-norm'), it runs a much slower pairwise distance to the boundary points.
#### 1.3 Experiments
## Problem 2
