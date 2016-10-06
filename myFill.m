function [imOut] = myFill(imIn)
	[n,m] = size(imIn);
	imOut = imIn;
	for i = 1:n
		v = imIn(i,:);
		a = find(v);
		if ~isempty(a)
			imOut(i,min(a):max(a)) = 1;
		end
	end
end
