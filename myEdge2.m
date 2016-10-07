function imOut = myEdge2(imIn, ths)
	% quantization
	thresh = multithresh(imIn,ths);
	A = imquantize(imIn,thresh);
	A =	im2double(A); 
	
	% x derivitive and y dervitive
	dx = [-0.5 0.5; -0.5 0.5];
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

	% otsu
	grad = derX.^2 + derY.^2;
	thresh = multithresh(grad,10);
	grad = imquantize(grad,thresh);
	grad = (grad>1);
	
	imOut = grad;
end
