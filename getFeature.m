function feature = getFeature(imIn,i,j,m,n)
	A = zeros(size(imIn));
	A(i:i+n,j:j+m-1) = 1;
	A(i:i+n,j+m:j+m+m-1) = -1;
	B = A.*imIn;
	feature = sum(sum(B));
end
