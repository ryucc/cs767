function [area] = myArea(bdd_points)
	int = myInteriorArea(bdd_points);
	bdd = myPerimeterLength(bdd_points);
	area = int + 0.5*bdd + 1;
end
