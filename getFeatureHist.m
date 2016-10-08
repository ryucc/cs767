function hist = getFeatureHist(imIn, m,n, nbins)
	features = [];
	[a,b] = size(imIn);
	temp = uint32(imIn);
	integral = zeros([a,b],'uint32');
	for i = 1:a
		temp = wshift(2,temp,[-1,0]);
		temp(1,:) = 0;
		integral = integral + temp;
	end
	temp = integral;
	for i = 1:b
		temp = wshift(2,temp,[0,-1]);
		temp(:,1) = 0;
		integral = integral + temp;
	end
	mesh(integral);
	A = zeros([a+1,b+1]);
	A(2:end,2:end) = integral;
	integral = A;
	for i = 1:a-n
		for j = 1:b-2*m
			left = integral(i+n+1,j+m+1) + integral(i,j) - integral(i+n+1,j) - integral(i,j+m+1);
			right = integral(i+n+1,j+2*m-1) + integral(i,j+m) - integral(i+n+1,j+m) - integral(i,j+2*m-1);
			features = [features left-right];
		end
	end
	hist = histogram(features,nbins);
end
