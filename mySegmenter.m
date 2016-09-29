function [imOut] = mySegmenter(imIn,method)
	imOut = 0;
	if islogical(imIn)
		imOut = imIn;
	elseif isinteger(imIn)
        % create spectrum
		count = zeros(1,256);
        for i = 1:256
            count(i) = sum(sum(imIn == i-1));
        end

        % weight
		total = sum(count);
        w = 0:1:255;
		cw = w.*count;

		intraVar = zeros(1,255);	
		for i = 1:255
			t1 = sum(count(1:i));
			t2 = sum(count(i+1:256));
			w1 = sum(cw(1:i));
			w2 = sum(cw(i+1:256));
			a1 = w1/t1;
			a2 = w2/t2;
			intraVar(i) = (t1/total)*(t2/total)*(a1-a2)^2;
		end

		%get max intraVar
		[x,y] = max(intraVar);
		imOut = imIn>=y;
	elseif isdouble(imIn)
		[a,b] = size(imIn);
		v = reshape(imIn,a*b);
		v = sort(v);
		len = a*b;

	end

end
