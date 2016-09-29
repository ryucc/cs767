function [bdd_points, length, area] = myPerimeter(imIn,method)
	[n,m] = size(imIn);
	vbackward = [];
	vforward = [];
	area = 0;
	for i = 1:n
		v = imIn(i,:);
		a = find(v);
		if ~isempty(a)
			vforward = [vforward [i;min(a)]];
			vbackward = [vbackward [i;max(a)]];
			area = area + max(a) - min(a) + 1;
		end
	end
	if isequal(vbackward(end),vforward(end))
		vbackward = vbackward(:,1:end-1);
		bdd_points = [vforward fliplr(vbackward)]
		if isequal(bdd_points(1),bdd_points(end))
			bdd_points = bdd_points(:,1:end-1);
		end
	else
		bdd_points = [vforward fliplr(vbackward)]
		if isequal(bdd_points(1),bdd_points(end))
			bdd_points = bdd_points(1:end-1,:);
		end
	end
	length = myPerimeterLength(bdd_points);
end
