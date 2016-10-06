function [length] = myDiameter(bdd_points)
	max_dist = 0;
	[n,m] = size(bdd_points);
	for i=1:m
		for j = i+1:m
			v = bdd_points(:,i)-bdd_points(:,j);
			d = norm(v);
			if d> max_dist
				max_dist = d;
			end
		end
	end
	length = max_dist;
	
end
