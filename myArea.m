function area = myArea(bdd_points)
	[n,m] = size(bdd_points);
	if m < 3
		area = 0;
		return;
	end
	origin = bdd_points(:,1);
	area = 0;
	first = bdd_points(:,2);
	second = bdd_points(:,3);
	for i = 3:m
		second = bdd_points(:,i);
		area = area + 1/2 * (origin(1)*(first(2)-second(2)));
		area = area + 1/2 * (first(1)*(second(2)-origin(2)));
		area = area + 1/2 * (second(1)*(origin(2)-first(2)));
		first = second;
	end
	area = abs(area);
	area = area + m/2 - 1;
end
