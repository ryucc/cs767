function imOut = myModeFilt(imIn)
	[n,m] = size(imIn);
	imOut = 0*imIn;
	for i=2:n-1
		for j=2:m-1
			nei = 0;
			for k = -1:1
			for l = -1:1
				if imIn(i+k,j+l) == imIn(i,j)
					nei = nei+1;
				end
			end
			end
			if nei<5
			imOut(i,j) = mode(reshape(imIn(i-1:i+1,j-1:j+1),[1,9]));
			end
		end
	end
end
