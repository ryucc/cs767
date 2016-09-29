function [length] = myPerimeterLength(bdd_points)
	% length
	length = 0;
	b1 = [[0;0] bdd_points];
	b2 = [bdd_points [0;0]];
	b3 = sum((b1-b2).^2).^(1/2);
	b3 = b3(2:end-1);
	length = sum(b3);
end
