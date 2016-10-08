function [A,B] = myDT(imIn,method)
	imIn = mySegmenter(imIn,1);
	bdd_points = myPerimeter(imIn);
	if nargin > 1 & strcmp('2-norm',method)
		[n,m] = size(imIn);
		imOut = (n+n+m+m)*ones(size(imIn),'double');
        crdY = repmat((1:m),[n,1]);
        crdX = repmat((1:n)',[1,m]);
		for a=bdd_points
            temp = (crdX-a(1)).^2 + (crdY-a(2)).^2;
            temp = temp .^0.5;
            imOut = min(imOut,temp);
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
    imOut = cat(3,0.5*imOut,0.5*imOut,(0.9)*imOut);
    imOut = imOut/max(max(max(imOut)));
    imOut(:,:,1) = 1-imOut(:,:,1);
    mask = cat(3,imIn,imIn,imIn);
	A = imOut.*mask;
	B = imOut.*(~mask);
end
