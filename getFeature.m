function feature = getFeature(imIn,i,j,m,n)
	[n,m] = size(size(imIn));
	if m == 3
		imIn = rgb2gray(imIn);
	end
	size(imIn)
	A = zeros(size(imIn),'double');
	imIn = double(imIn);
	A(i:i+n,j:j+m-1) = 1;
	A(i:i+n,j+m:j+m+m-1) = -1;
	B = A.*imIn;
	feature = sum(sum(B));
end
