function [bdd_points, bdd_length, area, diameter] = myPerimeter(imIn)
	[n,m] = size(imIn);
	vbackward = [];
	vforward = [];
	vtop = [];
	vbottom = [];
	area = 0;
	prev_forward = -1;
	prev_backward = -1;
	for i = 1:n
		v = imIn(i,:);
		a = find(v);
		if ~isempty(a)
			if prev_forward ~= -1
				if min(a) < prev_forward-1
					vforward = [vforward [i*ones(1,prev_forward-min(a)-1);prev_forward-1:-1:min(a)+1]];
				elseif min(a) > prev_forward+1
					vforward = [vforward [(i-1)*ones(1,min(a)-prev_forward-1);prev_forward+1:min(a)-1]];
				end
			end
			if prev_backward ~= -1
				if max(a) < prev_backward-1
					vbackward = [vbackward [(i-1)*ones(1,prev_backward-max(a)-1);prev_backward-1:-1:max(a)+1]];
				elseif max(a) > prev_backward+1
					vbackward = [vbackward [i*ones(1,-prev_backward+max(a)-1);prev_backward+1:max(a)-1]];
				end
			end
			vforward = [vforward [i;min(a)]];
			vbackward = [vbackward [i;max(a)]];
			area = area + max(a) - min(a) + 1;
			prev_forward = min(a);
			prev_backward = max(a);
		end
	end
	for i = 1:n
		v = imIn(i,:);
		a = find(v);
		if ~isempty(a)
			length = max(a) - min(a) + 1;
			vtop = [i*ones(1,length); max(a):-1:min(a)];
			break;
		end
	end
	for i = n:-1:1
		v = imIn(i,:);
		a = find(v);
		if ~isempty(a)
			length = max(a) - min(a) + 1;
			vbottom = [i*ones(1,length); min(a):max(a)];
			break;
		end
	end
	bdd_points = [vforward vbottom fliplr(vbackward) vtop];

	bdd_length = myPerimeterLength(bdd_points);
	diameter = myDiameter(bdd_points);
end
