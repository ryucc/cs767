function imOut = myEdge(imIn, sigma)
	% gaussian filter
	A = im2double(imIn);
	gauss = fspecial('gaussian', 5 ,sigma);
	A = conv2(A,gauss);
	A = conv2(A,gauss);
	% x derivitive and y dervitive
	dx = [-0.5 0 0.5;-1 0 1; -0.5 0 0.5];
	dy = dx';
	derX = conv2(A,dx);
	derY = conv2(A,dy);
	[n,m] = size(derX);
	lderX = reshape(derX,[1,n*m]);
	lderY = reshape(derY,[1,n*m]);
	% create quiver
	cordX = (1:n*m)/n+1;
	cordY = mod((n*m:-1:1),n);
	quiver(cordX,cordY,lderX,-lderY);
	
	%non-maxium surpression
	[n,m] = size(derX);
	isEdge = derX~=0 | derY~=0;
	for i = 2:n-1
		for j = 2:m-1
			if derX(i,j) == 0
				break
			end
			if derY(i,j) == 0
				break
			end
			r = derX(i,j) / derY(i,j);
			if abs(r) == 1
				a = sign(derX(i,j));
				b = sign(derY(i,j));
				if norm([derX(i+a,j+b),derY(i+a,j+b)])> norm([derX(i,j),derY(i,j)])
					isEdge(i,j) = 0;
				elseif norm([derX(i-a,j-b),derY(i-a,j-b)])> norm([derX(i,j),derY(i,j)])
					isEdge(i,j) = 0;
				end
			else if abs(r)< 1
				r = abs(r);
				a = sign(derX(i,j));
				b = sign(derY(i,j));
				qx = r*derX(i,j+b)+(1-r)*derX(i+a,j+b);
				qy = r*derY(i,j+b)+(1-r)*derY(i+a,j+b);
				px = r*derX(i,j-b)+(1-r)*derX(i-a,j-b);
				py = r*derY(i,j-b)+(1-r)*derY(i-a,j-b);
				if norm([qx,qy]) >	norm([derX(i,j),derY(i,j)])
					isEdge(i,j) = 0;
				elseif norm([px,py]) >	norm([derX(i,j),derY(i,j)])
					isEdge(i,j) = 0;
				end
			else
				r = 1/abs(r);
				a = sign(derX(i,j));
				b = sign(derY(i,j));
				qx = r*derX(i+a,j)+(1-r)*derX(i+a,j+b);
				qy = r*derY(i+a,j)+(1-r)*derY(i+a,j+b);
				px = r*derX(i-a,j)+(1-r)*derX(i-a,j-b);
				py = r*derY(i-a,j)+(1-r)*derY(i-a,j-b);
				if norm([qx,qy]) >	norm([derX(i,j),derY(i,j)])
					isEdge(i,j) = 0;
				elseif norm([px,py]) >	norm([derX(i,j),derY(i,j)])
					isEdge(i,j) = 0;
				end
			end
		end
	end
	isEdge(1:2,:) = 0;
	isEdge(end-1:end,:) = 0;
	isEdge(:,1:2) = 0;
	isEdge(:,end-1:end) = 0;
	neighbor = [1 1 1;1 0 1; 1 1 1];
	temp = conv2(double(isEdge),neighbor);
	imOut = isEdge&(temp(2:n+1,2:m+1)>1);
end
