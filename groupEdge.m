function [imOut] = groupEdge(imIn,i,j)
	[n,m] = size(imIn);
	visited = zeros(n,m,'logical');
	stack = [i;j];
	while ~isempty(stack)
		x = stack(:,end);
		stack = stack(:,1:end-1);
		for k = -1:1
			for l = -1:1
				if x(1)+k > 0 & x(1) + k <= n & x(2) + l > 0 & x(2)+l <= m
					if ~visited(x(1)+k,x(2)+l) & imIn(x(1)+k,x(2)+l)
						visited(x(1)+k,x(2)+l) = 1;
						stack = [stack [x(1)+k;x(2)+l]];
					end
				end
			end
		end
	end
	imOut = visited;
end
