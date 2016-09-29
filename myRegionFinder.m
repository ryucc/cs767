function [imOut] = myRegionFinder(imIn)
	[n,m] = size(imIn);
	visited = zeros(n,m);
	comp = 0;
	for i = 1:n
		for j = 1:m
			if visited(i,j) | ~imIn(i,j) 
				continue;
			end
			comp = comp+10;
			visited(i,j) = comp;
			stack = [i;j];
			while ~isempty(stack)
				x = stack(:,end);
				stack = stack(:,1:end-1);
				for k = -1:1
					for l = -1:1
						if x(1)+k > 0 & x(1) + k < n & x(2) + l > 0 & x(2)+l < n
							if ~visited(x(1)+k,x(2)+l) & imIn(x(1)+k,x(2)+l)
								visited(x(1)+k,x(2)+l) = comp;
								stack = [stack [x(1)+k;x(2)+l]];
							end
						end
					end
				end
			end
		end
	end
end
