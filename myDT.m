function [A,B] = myDT(imIn,method)
	if ~islogical(imIn)
		imIn = mySegmenter(imIn);
	end
	bdd_points = myPerimeter(imIn);
	if nargin > 1 & strcmp('2-norm',method)
		imOut = zeros(size(imIn),'double');
		[n,m] = size(imIn);
		for i=1:n
			for j=1:m
				min_dist = n+m;
				for a=bdd_points
					v = a - [i;j];
					d = norm(v);
					if d<min_dist
						min_dist = d;
					end
				end
				imOut(i,j) = min_dist;
			end
		end
	else
	% BFS, on 4-neighborhood.
		[n,m] = size(imIn);
		imOut = (n+m) * ones(size(imIn));
		cur = bdd_points;
		next = [];
		for i = cur
			imOut(i(1),i(2)) = 0;
		end
		for i = 1:(n+m)
			next = [];
			for center = cur
				x = center(1);
				y = center(2);
				if x-1 >= 1
					if y-1 >=1
						if imOut(x-1,y-1) > i
							imOut(x-1,y-1) = i;
							next = [next [x-1;y-1]];
						end
					end
					if y+1 <= m
						if imOut(x-1,y+1) > i
							imOut(x-1,y+1) = i;
							next = [next [x-1;y+1]];
						end
					end
				end
				if x+1 <= n
					if y-1 >=1
						if imOut(x+1,y-1) > i
							imOut(x+1,y-1) = i;
							next = [next [x+1;y-1]];
						end
					end
					if y+1 <= m
						if imOut(x+1,y+1) > i
							imOut(x+1,y+1) = i;
							next = [next [x+1;y+1]];
						end
					end
				end
			end
			cur = next;
			%imOut
		end
		n+m
	end
	A = imOut.*imIn;
	B = imOut.*(~imIn);
end
